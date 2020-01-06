set lin 160;

DROP TABLE dostarcza;
DROP TABLE potrzebuje;
DROP TABLE obejmuje;


CREATE TABLE dostarcza (
  co VARCHAR2(10),
  czego VARCHAR2(10),
  ile NUMBER(3),
  CONSTRAINT dostarcza_pk PRIMARY KEY (co, czego)
);

CREATE TABLE potrzebuje (
  kto VARCHAR2(10),
  czego VARCHAR2(10),
  ile NUMBER(4),
  CONSTRAINT potrzebuje_pk PRIMARY KEY (kto, czego)
);


CREATE TABLE obejmuje (
  posilek VARCHAR2(12),
  co VARCHAR2(10),
  ile number(1),
  CONSTRAINT obejmuje_pk PRIMARY KEY (posilek, co)
);

INSERT INTO dostarcza VALUES ('awokado', 'energia', 160);
INSERT INTO dostarcza VALUES ('awokado', 'bialko', 2);
INSERT INTO dostarcza VALUES ('awokado', 'tluszcze', 15);
INSERT INTO dostarcza VALUES ('awokado', 'cukry', 7);

INSERT INTO dostarcza VALUES ('bigos', 'energia', 126);
INSERT INTO dostarcza VALUES ('bigos', 'bialko', 6);
INSERT INTO dostarcza VALUES ('bigos', 'tluszcze', 10);
INSERT INTO dostarcza VALUES ('bigos', 'cukry', 4);

INSERT INTO dostarcza VALUES ('chleb', 'energia', 196);
INSERT INTO dostarcza VALUES ('chleb', 'bialko', 5);
INSERT INTO dostarcza VALUES ('chleb', 'tluszcze', 1);
INSERT INTO dostarcza VALUES ('chleb', 'cukry', 41);

INSERT INTO dostarcza VALUES ('dorsz', 'energia', 70);
INSERT INTO dostarcza VALUES ('dorsz', 'bialko', 16);
INSERT INTO dostarcza VALUES ('dorsz', 'tluszcze', 0);
INSERT INTO dostarcza VALUES ('dorsz', 'cukry', 0);

INSERT INTO dostarcza VALUES ('endywia', 'energia', 17);
INSERT INTO dostarcza VALUES ('endywia', 'bialko', 2);
INSERT INTO dostarcza VALUES ('endywia', 'tluszcze', 1);
INSERT INTO dostarcza VALUES ('endywia', 'cukry', 1);

INSERT INTO dostarcza VALUES ('fasola', 'energia', 346);
INSERT INTO dostarcza VALUES ('fasola', 'bialko', 21);
INSERT INTO dostarcza VALUES ('fasola', 'tluszcze', 2);
INSERT INTO dostarcza VALUES ('fasola', 'cukry', 62);

INSERT INTO dostarcza VALUES ('gruszka', 'energia', 62);
INSERT INTO dostarcza VALUES ('gruszka', 'bialko', 1);
INSERT INTO dostarcza VALUES ('gruszka', 'tluszcze', 0);
INSERT INTO dostarcza VALUES ('gruszka', 'cukry', 14);

INSERT INTO dostarcza VALUES ('homar', 'energia', 85);
INSERT INTO dostarcza VALUES ('homar', 'bialko', 19);
INSERT INTO dostarcza VALUES ('homar', 'tluszcze', 1);
INSERT INTO dostarcza VALUES ('homar', 'cukry', 0);

INSERT INTO dostarcza VALUES ('indyk', 'energia', 110);
INSERT INTO dostarcza VALUES ('indyk', 'bialko', 21);
INSERT INTO dostarcza VALUES ('indyk', 'tluszcze', 3);
INSERT INTO dostarcza VALUES ('indyk', 'cukry', 0);

INSERT INTO dostarcza VALUES ('jajo', 'energia', 150);
INSERT INTO dostarcza VALUES ('jajo', 'bialko', 12);
INSERT INTO dostarcza VALUES ('jajo', 'tluszcze', 11);
INSERT INTO dostarcza VALUES ('jajo', 'cukry', 1);

INSERT INTO dostarcza VALUES ('kisiel', 'energia', 103);
INSERT INTO dostarcza VALUES ('kisiel', 'bialko', 0);
INSERT INTO dostarcza VALUES ('kisiel', 'tluszcze', 0);
INSERT INTO dostarcza VALUES ('kisiel', 'cukry', 25);

INSERT INTO dostarcza VALUES ('lody', 'energia', 120);
INSERT INTO dostarcza VALUES ('lody', 'bialko', 2);
INSERT INTO dostarcza VALUES ('lody', 'tluszcze', 6);
INSERT INTO dostarcza VALUES ('lody', 'cukry', 14);

INSERT INTO dostarcza VALUES ('muesli', 'energia', 370);
INSERT INTO dostarcza VALUES ('muesli', 'bialko', 9);
INSERT INTO dostarcza VALUES ('muesli', 'tluszcze', 7);
INSERT INTO dostarcza VALUES ('muesli', 'cukry', 68);

INSERT INTO dostarcza VALUES ('nutella', 'energia', 533);
INSERT INTO dostarcza VALUES ('nutella', 'bialko', 6);
INSERT INTO dostarcza VALUES ('nutella', 'tluszcze', 31);
INSERT INTO dostarcza VALUES ('nutella', 'cukry', 57);

INSERT INTO dostarcza VALUES ('ostrygi', 'energia', 85);
INSERT INTO dostarcza VALUES ('ostrygi', 'bialko', 5);
INSERT INTO dostarcza VALUES ('ostrygi', 'tluszcze', 5);
INSERT INTO dostarcza VALUES ('ostrygi', 'cukry', 5);

INSERT INTO dostarcza VALUES ('piwo', 'energia', 42);
INSERT INTO dostarcza VALUES ('piwo', 'bialko', 5);
INSERT INTO dostarcza VALUES ('piwo', 'tluszcze', 0);
INSERT INTO dostarcza VALUES ('piwo', 'cukry', 5);

INSERT INTO dostarcza VALUES ('ryz', 'energia', 349);
INSERT INTO dostarcza VALUES ('ryz', 'bialko', 7);
INSERT INTO dostarcza VALUES ('ryz', 'tluszcze', 1);
INSERT INTO dostarcza VALUES ('ryz', 'cukry', 79);

INSERT INTO dostarcza VALUES ('ser', 'energia', 330);
INSERT INTO dostarcza VALUES ('ser', 'bialko', 29);
INSERT INTO dostarcza VALUES ('ser', 'tluszcze', 23);
INSERT INTO dostarcza VALUES ('ser', 'cukry', 2);

INSERT INTO dostarcza VALUES ('tunczyk', 'energia', 189);
INSERT INTO dostarcza VALUES ('tunczyk', 'bialko', 27);
INSERT INTO dostarcza VALUES ('tunczyk', 'tluszcze', 9);
INSERT INTO dostarcza VALUES ('tunczyk', 'cukry', 0);

INSERT INTO dostarcza VALUES ('udziec', 'energia', 234);
INSERT INTO dostarcza VALUES ('udziec', 'bialko', 18);
INSERT INTO dostarcza VALUES ('udziec', 'tluszcze', 18);
INSERT INTO dostarcza VALUES ('udziec', 'cukry', 0);

INSERT INTO dostarcza VALUES ('wino', 'energia', 75);
INSERT INTO dostarcza VALUES ('wino', 'bialko', 0);
INSERT INTO dostarcza VALUES ('wino', 'tluszcze', 0);
INSERT INTO dostarcza VALUES ('wino', 'cukry', 3);

INSERT INTO dostarcza VALUES ('ziemniaki', 'energia', 87);
INSERT INTO dostarcza VALUES ('ziemniaki', 'bialko', 2);
INSERT INTO dostarcza VALUES ('ziemniaki', 'tluszcze', 0);
INSERT INTO dostarcza VALUES ('ziemniaki', 'cukry', 20);


INSERT INTO potrzebuje VALUES ('M', 'energia', 3000);
INSERT INTO potrzebuje VALUES ('K', 'energia', 2200);
INSERT INTO potrzebuje VALUES ('D', 'energia', 2450);

INSERT INTO potrzebuje VALUES ('M', 'bialko', 75);
INSERT INTO potrzebuje VALUES ('K', 'bialko', 70);
INSERT INTO potrzebuje VALUES ('D', 'bialko', 90);

INSERT INTO potrzebuje VALUES ('M', 'tluszcze', 75);
INSERT INTO potrzebuje VALUES ('K', 'tluszcze', 65);
INSERT INTO potrzebuje VALUES ('D', 'tluszcze', 90);

INSERT INTO potrzebuje VALUES ('M', 'cukry', 415);
INSERT INTO potrzebuje VALUES ('K', 'cukry', 365);
INSERT INTO potrzebuje VALUES ('D', 'cukry', 450);


INSERT INTO obejmuje VALUES ('Dublin', 'ostrygi', 2);
INSERT INTO obejmuje VALUES ('Dublin', 'piwo', 5);

INSERT INTO obejmuje VALUES ('Kazio', 'chleb', 2);
INSERT INTO obejmuje VALUES ('Kazio', 'nutella', 1);

INSERT INTO obejmuje VALUES ('Jadzia', 'muesli', 2);

INSERT INTO obejmuje VALUES ('Radom', 'ser', 1);
INSERT INTO obejmuje VALUES ('Radom', 'chleb', 1);

INSERT INTO obejmuje VALUES ('Nicea', 'tunczyk', 1);
INSERT INTO obejmuje VALUES ('Nicea', 'ryz', 2);
INSERT INTO obejmuje VALUES ('Nicea', 'jajo', 1);

INSERT INTO obejmuje VALUES ('Wege', 'fasola', 1);
INSERT INTO obejmuje VALUES ('Wege', 'ryz', 1);
INSERT INTO obejmuje VALUES ('Wege', 'endywia', 2);

INSERT INTO obejmuje VALUES ('Post', 'dorsz', 2);
INSERT INTO obejmuje VALUES ('Post', 'ziemniaki', 3);
INSERT INTO obejmuje VALUES ('Post', 'endywia', 4);

INSERT INTO obejmuje VALUES ('Janusz', 'bigos', 6);
INSERT INTO obejmuje VALUES ('Janusz', 'chleb', 2);
INSERT INTO obejmuje VALUES ('Janusz', 'piwo', 5);
INSERT INTO obejmuje VALUES ('Janusz', 'kisiel', 2);

INSERT INTO obejmuje VALUES ('Dzesika', 'homar', 2);
INSERT INTO obejmuje VALUES ('Dzesika', 'gruszka', 3);
INSERT INTO obejmuje VALUES ('Dzesika', 'ryz', 2);
INSERT INTO obejmuje VALUES ('Dzesika', 'wino', 2);

INSERT INTO obejmuje VALUES ('Andzela', 'awokado', 1);
INSERT INTO obejmuje VALUES ('Andzela', 'ryz', 2);
INSERT INTO obejmuje VALUES ('Andzela', 'lody', 4);

INSERT INTO obejmuje VALUES ('Janusz light', 'bigos', 4);
INSERT INTO obejmuje VALUES ('Janusz light', 'piwo', 3);
INSERT INTO obejmuje VALUES ('Janusz light', 'kisiel', 2);

INSERT INTO obejmuje VALUES ('Roman', 'udziec', 1);
INSERT INTO obejmuje VALUES ('Roman', 'ziemniaki', 2);

INSERT INTO obejmuje VALUES ('Halina', 'indyk', 1);
INSERT INTO obejmuje VALUES ('Halina', 'ryz', 1);
INSERT INTO obejmuje VALUES ('Halina', 'endywia', 2);

INSERT INTO obejmuje VALUES ('Leniwy Roman', 'udziec', 1);
INSERT INTO obejmuje VALUES ('Leniwy Roman', 'chleb', 2);

COMMIT;
