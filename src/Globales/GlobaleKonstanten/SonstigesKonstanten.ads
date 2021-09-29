pragma SPARK_Mode (On);

with GlobaleDatentypen, DatenbankRecords, WichtigeRecords, KartenRecords;

package SonstigesKonstanten is
   
   RassenMulitplikationWert : constant GlobaleDatentypen.BelegterGrund := 1_000;

   LeerCursorGrafik : constant Wide_Wide_Character := '©';
   LeerPosition : constant KartenRecords.AchsenKartenfeldPositivRecord := (0, 0, 0);
   LeerPositionStadt : constant KartenRecords.AchsenStadtfeldRecord := (1, 1);
   
   LeerCursor : constant KartenRecords.CursorRecord := (
                                                        CursorGrafik  => LeerCursorGrafik,
                                                        Position      => LeerPosition,
                                                        PositionAlt   => LeerPosition,
                                                        PositionStadt => LeerPositionStadt
                                                       );
   
   LeerGeldmenge : constant Integer := 100;
   LeerGeldZugewinnProRunde : constant GlobaleDatentypen.KostenLager := 0;
   LeerGesamteForschungsrate : constant GlobaleDatentypen.KostenLager := 0;
   LeerForschungsmenge : constant GlobaleDatentypen.KostenLager := 0;
   LeerVerbleibendeForschungszeit : constant GlobaleDatentypen.KostenLager := GlobaleDatentypen.KostenLager'Last;
   LeerForschungsprojekt : constant GlobaleDatentypen.ForschungIDMitNullWert := GlobaleDatentypen.ForschungIDMitNullWert'First;
   LeerErforscht : constant Boolean := False;
   LeerAnzahlStädte : constant GlobaleDatentypen.MaximaleStädteMitNullWert := GlobaleDatentypen.MaximaleStädteMitNullWert'First;
   LeerAnzahlArbeiter : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := GlobaleDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerAnzahlKämpfer : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := GlobaleDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerAnzahlSonstiges : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := GlobaleDatentypen.MaximaleEinheitenMitNullWert'First;
   
   LeerWichtigesZeug : constant WichtigeRecords.WichtigesRecord := (
                                                                    Geldmenge                  => LeerGeldmenge,
                                                                    GeldZugewinnProRunde       => LeerGeldZugewinnProRunde,
                                                                    GesamteForschungsrate      => LeerGesamteForschungsrate,
                                                                    Forschungsmenge            => LeerForschungsmenge,
                                                                    VerbleibendeForschungszeit => LeerVerbleibendeForschungszeit,
                                                                    Forschungsprojekt          => LeerForschungsprojekt,
                                                                    Erforscht                  => (others => LeerErforscht),
                                                                    AnzahlStädte               => LeerAnzahlStädte,
                                                                    AnzahlArbeiter             => LeerAnzahlArbeiter,
                                                                    AnzahlKämpfer              => LeerAnzahlKämpfer,
                                                                    AnzahlSonstiges            => LeerAnzahlSonstiges
                                                                   );
   
   LeerStädtegrenze : constant GlobaleDatentypen.MaximaleStädte := GlobaleDatentypen.MaximaleStädte'Last;
   LeerEinheitengrenze : constant GlobaleDatentypen.MaximaleEinheiten := GlobaleDatentypen.MaximaleEinheiten'Last;
   LeerGeldgrenze : constant Integer := Integer'Last;
   LeerForschungsgrenze : constant GlobaleDatentypen.KostenLager:= GlobaleDatentypen.KostenLager'Last;
   LeerGeldgewinngrenze : constant GlobaleDatentypen.KostenLager := GlobaleDatentypen.KostenLager'Last;
   LeerForschungGewinngrenze : constant GlobaleDatentypen.KostenLager := GlobaleDatentypen.KostenLager'Last;
   LeerRassenRundengrenze : constant Natural := Natural'First;

   LeerGrenzen : constant WichtigeRecords.GrenzenRecord := (
                                                            Städtegrenze          => LeerStädtegrenze,
                                                            Einheitengrenze       => LeerEinheitengrenze,
                                                            Geldgrenze            => LeerGeldgrenze,
                                                            Forschungsgrenze      => LeerForschungsgrenze,
                                                            Geldgewinngrenze      => LeerGeldgewinngrenze,
                                                            ForschungGewinngrenze => LeerForschungGewinngrenze,
                                                            RassenRundengrenze    => LeerRassenRundengrenze
                                                           );
   
   LeerAktuellerZustand : constant GlobaleDatentypen.Status_Untereinander_Enum := GlobaleDatentypen.Unbekannt;
   LeerAktuelleSympathieBewertung : constant GlobaleDatentypen.ProduktionFeld := 0;
   LeerZeitSeitLetzterÄnderung : constant Natural := Natural'First;

   LeerDiplomatie : constant WichtigeRecords.DiplomatieRecord := (
                                                                  AktuellerZustand           => LeerAktuellerZustand,
                                                                  AktuelleSympathieBewertung => LeerAktuelleSympathieBewertung,
                                                                  ZeitSeitLetzterÄnderung    => LeerZeitSeitLetzterÄnderung
                                                                 );
   
   DiplomatischerStatusÄnderungszeit : constant Positive := 10;
   
   -- Wird noch nicht verwendet.
   LeerRassenListe : constant DatenbankRecords.RassenListeRecord := (
                                                                     Aggressivität       => 0,
                                                                     Expansion           => 0,
                                                                     Wissenschaft        => 0,
                                                                     Produktion          => 0,
                                                                     Wirtschaft          => 0,
                                                                     Bewirtschaftung     => 0,
                                                                     GültigeStaatsformen => (GlobaleDatentypen.Anarchie,
                                                                                              GlobaleDatentypen.Anarchie,
                                                                                              GlobaleDatentypen.Anarchie,
                                                                                              GlobaleDatentypen.Anarchie,
                                                                                              GlobaleDatentypen.Anarchie)
                                                                    );

end SonstigesKonstanten;
