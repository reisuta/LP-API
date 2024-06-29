START TRANSACTION;

CREATE TABLE IF NOT EXISTS evaluations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  logic_type ENUM('weighting', 'time_based', 'other') NOT NULL DEFAULT 'weighting',
  score INT
);

COMMIT;
