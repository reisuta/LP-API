use lp_api;

START TRANSACTION;
-- diagnosesテーブルにデータを挿入し、IDを取得
INSERT INTO diagnoses (title) VALUES ('文豪性格診断');
SET @diagnosis_id_1 = LAST_INSERT_ID();

INSERT INTO diagnoses (title) VALUES ('メタル性格診断');
SET @diagnosis_id_2 = LAST_INSERT_ID();

INSERT INTO diagnoses (title) VALUES ('月並み性格診断');
SET @diagnosis_id_3 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id) VALUES
('お酒を飲む頻度とそのスタイルを教えてください', 10, 'radio', true, @diagnosis_id_1);
SET @question_id_1 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id) VALUES
('どの思想に共感しますか？', 20, 'radio', true, @diagnosis_id_1);
SET @question_id_2 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id) VALUES
('世間で言われるところの「常識」についてどう思いますか？', 15, 'radio', true, @diagnosis_id_1);
SET @question_id_3 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, question_id) VALUES
('お酒はほとんど飲まない。', 0, true, @question_id_1),
('お酒は週1、2回程度飲む。お酒にあまり強くない、もしくは普通のため、付き合いでちょっと飲む程度。', 0, true, @question_id_1),
('ほとんど毎日飲む。好きな酒のこだわりはなく、手持ち無沙汰で飲んでいる。お酒を飲める人はかっこいいと思う。', 0, true, @question_id_1),
('毎日飲まなきゃやってらんない。酒の味が大好きで、仲間と飲むのが楽しいから毎日飲む。', 0, true, @question_id_1),
('毎日飲まなきゃやってらんない。たいてい一人で飲む。そして本当は酒はあまり好きじゃない', 5, true, @question_id_1);

INSERT INTO diagnoses_questions_choices (title, point, is_valid, question_id) VALUES
('みな機会において平等であるべきだ。そして、実力があるものこそ上に立つべきだ。', 5, true, @question_id_2),
('明るく社交的な人物は優秀であり、暗く内向的な人物は劣等である。', 0, true, @question_id_2),
('とにかく分かりやすく役に立ちそうなものを使えばいい。細かいことは考える必要はない。', 0, true, @question_id_2),
('何が正しいかなんてわからない。そのため何事も研究が欠かせない。', 5, true, @question_id_2),
('思想はある種の趣味で、固有のものだから、共感できる思想はない。', 10, true, @question_id_2);

INSERT INTO diagnoses_questions_choices (title, point, is_valid, question_id) VALUES
('非常識にならないためにも、遵守すべき規範であり、絶対に守らなければならないと思う。', 0, true, @question_id_3),
('常識がないやつは、変なやつだと思うので、私は嫌いだ。なお私は常識人です。', 0, true, @question_id_3),
('常識の定義がいまいちわからないので、答えかねます。', 5, true, @question_id_3),
('「世間の常識では」と説教する人が言う、「常識」は、その人の主観でしかないと思う。', 10, true, @question_id_3),
('常識が正しいと信じ込むのは、思考停止だと思う。', 10, true, @question_id_3);

-- トランザクションをコミット
COMMIT;
