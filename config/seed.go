package config

import (
	"log"
)

// SeedData seeds the database with initial data
func SeedData() {
	tx, err := DB.Begin()
	if err != nil {
		log.Fatalf("Error beginning transaction: %s\n", err.Error())
	}

	defer func() {
		if err != nil {
			tx.Rollback()
		} else {
			tx.Commit()
		}
	}()

	var diagnosisIDs []int
	diagnosisTitles := []string{"文豪性格診断", "メタル性格診断", "月並み性格診断"}
	for _, title := range diagnosisTitles {
		res, err := tx.Exec(`INSERT INTO diagnoses (title) VALUES (?)`, title)
		if err != nil {
			log.Fatalf("Error seeding data: %s\n", err.Error())
		}
		id, err := res.LastInsertId()
		if err != nil {
			log.Fatalf("Error getting last insert ID: %s\n", err.Error())
		}
		diagnosisIDs = append(diagnosisIDs, int(id))
	}

	var questionIDs []int
	questions := []struct {
		Title       string
		Weighting   int
    Type        string
		IsValid     bool
		DiagnosisID int
	}{
    // 文豪性格診断だけ作る
		{"お酒を飲む頻度とそのスタイルを教えてください", 10, "radio", true, diagnosisIDs[0]},
		{"どの思想に共感しますか？", 20, "radio", true, diagnosisIDs[0]},
		{"世間で言われるところの「常識」についてどう思いますか？", 15, "radio", true, diagnosisIDs[0]},
	}

	for _, q := range questions {
		res, err := tx.Exec(`INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id) VALUES (?, ?, ?, ?, ?)`, q.Title, q.Weighting, q.Type, q.IsValid, q.DiagnosisID)
		if err != nil {
			log.Fatalf("Error seeding data: %s\n", err.Error())
		}
		id, err := res.LastInsertId()
		if err != nil {
			log.Fatalf("Error getting last insert ID: %s\n", err.Error())
		}
		questionIDs = append(questionIDs, int(id))
	}

	// diagnoses_questions_choicesを挿入
	choices := []struct {
		Title      string
		Point      int
		IsValid    bool
		QuestionID int
	}{
		{"お酒はほとんど飲まない。", 0, true, questionIDs[0]},
		{"お酒は週1、2回程度飲む。お酒にあまり強くない、もしくは普通のため、付き合いでちょっと飲む程度。", 0, true, questionIDs[0]},
		{"ほとんど毎日飲む。好きな酒のこだわりはなく、手持ち無沙汰で飲んでいる。お酒を飲める人はかっこいいと思う。", 0, true, questionIDs[0]},
		{"毎日飲まなきゃやってらんない。酒の味が大好きで、仲間と飲むのが楽しいから毎日飲む。", 0, true, questionIDs[0]},
		{"毎日飲まなきゃやってらんない。たいてい一人で飲む。そして本当は酒はあまり好きじゃない", 5, true, questionIDs[0]},

		{"みな機会において平等であるべきだ。そして、実力があるものこそ上に立つべきだ。", 5, true, questionIDs[1]},
		{"明るく社交的な人物は優秀であり、暗く内向的な人物は劣等である。", 0, true, questionIDs[1]},
		{"とにかく分かりやすく役に立ちそうなものを使えばいい。細かいことは考える必要はない。", 0, true, questionIDs[1]},
		{"何が正しいかなんてわからない。そのため何事も研究が欠かせない。", 5, true, questionIDs[1]},
		{"思想はある種の趣味で、固有のものだから、共感できる思想はない。", 10, true, questionIDs[1]},

		{"非常識にならないためにも、遵守すべき規範であり、絶対に守らなければならないと思う。", 0, true, questionIDs[2]},
		{"常識がないやつは、変なやつだと思うので、私は嫌いだ。なお私は常識人です。", 0, true, questionIDs[2]},
		{"常識の定義がいまいちわからないので、答えかねます。", 5, true, questionIDs[2]},
		{"「世間の常識では」と説教する人が言う、「常識」は、その人の主観でしかないと思う。", 10, true, questionIDs[2]},
		{"常識が正しいと信じ込むのは、思考停止だと思う。", 10, true, questionIDs[2]},
	}

	for _, c := range choices {
		_, err := tx.Exec(`INSERT INTO diagnoses_questions_choices (title, point, is_valid, question_id) VALUES (?, ?, ?, ?)`, c.Title, c.Point, c.IsValid, c.QuestionID)
		if err != nil {
			log.Fatalf("Error seeding data: %s\n", err.Error())
		}
	}

	log.Println("Database seeded with initial data.")
}
