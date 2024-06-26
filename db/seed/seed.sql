use lp_api;

START TRANSACTION;
-- diagnosesテーブルにデータを挿入し、IDを取得
INSERT INTO diagnoses (title) VALUES ('文豪性格診断');
SET @diagnosis_id_1 = LAST_INSERT_ID();

INSERT INTO diagnoses (title) VALUES ('メタル性格診断');
SET @diagnosis_id_2 = LAST_INSERT_ID();

INSERT INTO diagnoses (title) VALUES ('月並み性格診断');
SET @diagnosis_id_3 = LAST_INSERT_ID();

-- 一ページ目
INSERT INTO diagnoses_headers (diagnosis_id, title) VALUES (@diagnosis_id_1, '酒の悲哀');
SET @diagnosis_header_id_1 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('お酒を飲む頻度とそのスタイルを教えてください', 10, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_1);
SET @diagnosis_question_id_1 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('お酒はほとんど飲まない。', 0, true, @diagnosis_question_id_1),
('お酒は週1、2回程度飲む。お酒にあまり強くない、もしくは普通のため、付き合いでちょっと飲む程度。', 0, true, @diagnosis_question_id_1),
('ほとんど毎日飲む。好きな酒のこだわりはなく、手持ち無沙汰で飲んでいる。お酒を飲める人はかっこいいと思う。', 0, true, @diagnosis_question_id_1),
('毎日飲まなきゃやってらんない。酒の味が大好きで、仲間と飲むのが楽しいから毎日飲む。', 0, true, @diagnosis_question_id_1),
('毎日飲まなきゃやってらんない。たいてい一人で飲む。そして本当は酒はあまり好きじゃない', 5, true, @diagnosis_question_id_1);

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('どの思想に共感しますか？', 20, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_1);
SET @diagnosis_question_id_2 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('みな機会において平等であるべきだ。そして、実力があるものこそ上に立つべきだ。', 5, true, @diagnosis_question_id_2),
('明るく社交的な人物は優秀であり、暗く内向的な人物は劣等である。', 0, true, @diagnosis_question_id_2),
('とにかく分かりやすく役に立ちそうなものを使えばいい。細かいことは考える必要はない。', 0, true, @diagnosis_question_id_2),
('何が正しいかなんてわからない。そのため何事も研究が欠かせない。', 5, true, @diagnosis_question_id_2),
('思想はある種の趣味で、固有のものだから、共感できる思想はない。', 10, true, @diagnosis_question_id_2);

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('世間で言われるところの「常識」についてどう思いますか？', 15, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_1);
SET @diagnosis_question_id_3 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('非常識にならないためにも、遵守すべき規範であり、絶対に守らなければならないと思う。', 0, true, @diagnosis_question_id_3),
('常識がないやつは、変なやつだと思うので、私は嫌いだ。なお私は常識人です。', 0, true, @diagnosis_question_id_3),
('常識の定義がいまいちわからないので、答えかねます。', 5, true, @diagnosis_question_id_3),
('「世間の常識では」と説教する人が言う、「常識」は、その人の主観でしかないと思う。', 10, true, @diagnosis_question_id_3),
('常識が正しいと信じ込むのは、思考停止だと思う。', 10, true, @diagnosis_question_id_3);

-- 二ページ目
INSERT INTO diagnoses_headers (diagnosis_id, title) VALUES (@diagnosis_id_1, '月並みの悲哀');
SET @diagnosis_header_id_2 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('今まで「「私」とは何か？」と、自問したことはどれぐらいありましたか？', 15, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_2);
SET @diagnosis_question_id_4 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('一度もない', 0, true, @diagnosis_question_id_4),
('幼少期に一度あったかもしれない。', 5, true, @diagnosis_question_id_4),
('私自身は一度もないが、その問いに悩む人の気持ちはわからなくもない', 5, true, @diagnosis_question_id_4),
('青年時代、この問いについて真剣に考えたことがある。', 10, true, @diagnosis_question_id_4),
('生まれてこのかた、この問いから目を反らすことができないでいる。', 10, true, @diagnosis_question_id_4);

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('好きな本のタイプを教えてください。', 10, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_2);
SET @diagnosis_question_id_5 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('自己啓発、ビジネス書などの、ノウハウが書かれており、すぐに役立ちそうなもの', 0, true, @diagnosis_question_id_5),
('大衆小説や、漫画など、娯楽や暇つぶしに適している本', 5, true, @diagnosis_question_id_5),
('純文学や哲学書、専門書、学術書といった、自分なりに噛み砕いて考える必要がある本。', 10, true, @diagnosis_question_id_5);

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('どのようにして仕事を進めることが多いですか？', 10, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_2);
SET @diagnosis_question_id_6 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('チームで役割分担をし、自ら先頭に立って、みなに指示を出して仕事を進めていく。', 10, true, @diagnosis_question_id_6),
('誰の力も借りず一人で黙々と進める。またはそのようにして仕事をしたい。', 0, true, @diagnosis_question_id_6),
('自ら先頭に立つことは少ないが、周囲の人と協力して、チームで仕事を進める。', 5, true, @diagnosis_question_id_6),
('チームで仕事をするのは正直煩わしい。一人で自由にやりたい。', 0, true, @diagnosis_question_id_6),
('リーダーとして、部下に指示を出し、仕事を進めていく。', 10, true, @diagnosis_question_id_6);

-- 三ページ目
INSERT INTO diagnoses_headers (diagnosis_id, title) VALUES (@diagnosis_id_1, '社会の悲哀');
SET @diagnosis_header_id_3 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('理想的な仕事のペースはどの程度ですか？', 10, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_3);
SET @diagnosis_question_id_7 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('早く仕事をしても遅く仕事をしても給料は同じなので、のんびりだらだら進めたい。', 0, true, @diagnosis_question_id_7),
('少しでも早く仕事をした方が自身の成長につながるので、可能な限りスピーディーに進めたい。', 10, true, @diagnosis_question_id_7),
('早くも遅くもない、その人に合った適切なペースで仕事を進めるべきである。', 5, true, @diagnosis_question_id_7),
('だらだら仕事をしても生産性が上がらないので、テキパキ進めたい。', 10, true, @diagnosis_question_id_7),
('早く仕事をしてしまったら、次の仕事が来てしまい面倒だから、できるだけだらだら進める。', 0, true, @diagnosis_question_id_7);

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('どのように話すことが多いですか？', 10, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_3);
SET @diagnosis_question_id_8 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('結論を最初に話し、その後に理由などを付け加える', 10, true, @diagnosis_question_id_8),
('出来事や理由を先に話し、最後に結論を言う。', 0, true, @diagnosis_question_id_8),
('ジェスチャーを織り交ぜて、相手が理解しやすいよう工夫する。', 10, true, @diagnosis_question_id_8),
('世間話が多く、とりとめのない話し方をすることが多い。', 0, true, @diagnosis_question_id_8),
('人間嫌いなので、あんまり人と話さない。', 0, true, @diagnosis_question_id_8);

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('あなたは一億円を手に入れました。何に使いますか？', 10, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_3);
SET @diagnosis_question_id_9 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('事業やビジネスの拡大', 10, true, @diagnosis_question_id_9),
('自己のスキルアップ', 10, true, @diagnosis_question_id_9),
('放蕩', 0, true, @diagnosis_question_id_9),
('家族サービスに使う', 5, true, @diagnosis_question_id_9),
('仕事をやめる', 0, true, @diagnosis_question_id_9);

INSERT INTO diagnoses_headers (diagnosis_id, title) VALUES (@diagnosis_id_1, '芸術の悲哀');
SET @diagnosis_header_id_4 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('あなたが考える「変わり者」とはなんですか？', 15, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_4);
SET @diagnosis_question_id_10 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('非常識な言動が目立つ人', 0, true, @diagnosis_question_id_10),
('多くの人が持ちえない、独特の嗜好や考え方をする人', 0, true, @diagnosis_question_id_10),
('月並みでない、何らかの点で優秀な人', 0, true, @diagnosis_question_id_10),
('考えるも何も、変な人は変な人でしょ？', 0, true, @diagnosis_question_id_10),
('最も繊細な良心を持っている、周囲から理解されない孤独な人', 5, true, @diagnosis_question_id_10);

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('あなたが最も嫌いなものを教えてください。', 10, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_4);
SET @diagnosis_question_id_11 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('無能な部下や上司', 0, true, @diagnosis_question_id_11),
('分かったような迎合で、多数派におもねる人', 5, true, @diagnosis_question_id_11),
('常識人', 5, true, @diagnosis_question_id_11),
('面倒くさい人', 0, true, @diagnosis_question_id_11),
('非常識な人', 0, true, @diagnosis_question_id_11);

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('あなたが考える「化け物」とはなんですか？', 20, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_4);
SET @diagnosis_question_id_12 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('恐竜とか、虎のような凶暴な動物', 0, true, @diagnosis_question_id_12),
('アニメなどに出てくる鬼や、怪獣', 0, true, @diagnosis_question_id_12),
('そこらへんで散歩している、善良そうな人々', 5, true, @diagnosis_question_id_12),
('ある分野で、圧倒的な実績を叩き出した優秀な人', 0, true, @diagnosis_question_id_12),
('幽霊や妖怪', 0, true, @diagnosis_question_id_12);

INSERT INTO diagnoses_headers (diagnosis_id, title) VALUES (@diagnosis_id_1, '欲望の悲哀');
SET @diagnosis_header_id_5 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('煩悶、憂愁、懊悩。これらの言葉についてどう思いますか？', 20, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_5);
SET @diagnosis_question_id_13 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('そもそも初めて聞いた言葉なんですけど', 0, true, @diagnosis_question_id_13),
('なんでネガティブな言葉ばっかり並んでいるの？', 0, true, @diagnosis_question_id_13),
('文学的な言葉だと思う。美しく高等な言葉だと思う。', 5, true, @diagnosis_question_id_13),
('え、何自殺するの？(笑)', 0, true, @diagnosis_question_id_13),
('表現が一般的ではないため、あまり積極的に使用するべき言葉ではないと思う。', 0, true, @diagnosis_question_id_13);

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('あなたが不快に感じるものはなんですか？', 20, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_5);
SET @diagnosis_question_id_14 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('騒音や、乱暴な生活音',10, true, @diagnosis_question_id_14),
('野卑な笑い方', 0, true, @diagnosis_question_id_14),
('病気', 0, true, @diagnosis_question_id_14),
('自分勝手な人間', 0, true, @diagnosis_question_id_14),
('うるさい場所。または人混み', 10, true, @diagnosis_question_id_14);

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('人生でどうしても成し遂げたいことがありますが、それは自身の生活を犠牲にしなければ叶わないものでした。どうしますか？', 20, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_5);
SET @diagnosis_question_id_15 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('ワークライフバランスが第一なので、諦める', 0, true, @diagnosis_question_id_15),
('自分の生活をめちゃくちゃにしても、成し遂げるために努力を続ける。', 10, true, @diagnosis_question_id_15),
('迷わず生活を犠牲にして、遂行を目指す。', 10, true, @diagnosis_question_id_15),
('そのようなことは、そもそもしない。', 0, true, @diagnosis_question_id_15),
('生活を犠牲にしてしまったら元も子もないと思うから、しない。', 0, true, @diagnosis_question_id_15);

INSERT INTO diagnoses_headers (diagnosis_id, title) VALUES (@diagnosis_id_1, '最後の悲哀');
SET @diagnosis_header_id_6 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('理想的な死とはなんですか？', 20, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_6);
SET @diagnosis_question_id_16 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('大切な人に看取ってもらいながら、長寿を全うすること', 0, true, @diagnosis_question_id_16),
('狂死', 10, true, @diagnosis_question_id_16),
('自殺', 5, true, @diagnosis_question_id_16),
('病死', 0, true, @diagnosis_question_id_16),
('苦しみが一瞬で、すっと死ぬこと', 0, true, @diagnosis_question_id_16);

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('日々、何を感じることが多いですか？', 20, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_6);
SET @diagnosis_question_id_17 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('何も感じない', 0, true, @diagnosis_question_id_17),
('周囲の無理解', 0, true, @diagnosis_question_id_17),
('「ことり」と崩れそうな生活の音', 3, true, @diagnosis_question_id_17),
('自身の才能の不足', 7, true, @diagnosis_question_id_17),
('周囲の物音', 5, true, @diagnosis_question_id_17);

INSERT INTO diagnoses_questions (title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id) VALUES
('精神病院についてどう考えますか？', 10, 'radio', true, @diagnosis_id_1, @diagnosis_header_id_6);
SET @diagnosis_question_id_18 = LAST_INSERT_ID();

INSERT INTO diagnoses_questions_choices (title, point, is_valid, diagnosis_question_id) VALUES
('あまり良い印象はない。', 0, true, @diagnosis_question_id_18),
('最も常識的な人が入る場所だと思う。', 10, true, @diagnosis_question_id_18),
('なんとも思わない。または、どんな場所なのかよく知らない', 0, true, @diagnosis_question_id_18);

-- トランザクションをコミット
COMMIT;
