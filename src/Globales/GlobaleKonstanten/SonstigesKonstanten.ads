pragma SPARK_Mode (On);

with WichtigeRecords;
with KartenRecords;
with EinheitStadtDatentypen;
with KartenDatentypen;
with SonstigeDatentypen;

with DatenbankRecords;

package SonstigesKonstanten is
   
   RassenMulitplikationWert : constant KartenDatentypen.BelegterGrund := 1_000;

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
   LeerGeldZugewinnProRunde : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerGesamteForschungsrate : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerForschungsmenge : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerVerbleibendeForschungszeit : constant EinheitStadtDatentypen.KostenLager := EinheitStadtDatentypen.KostenLager'Last;
   LeerForschungsprojekt : constant EinheitStadtDatentypen.ForschungIDMitNullWert := EinheitStadtDatentypen.ForschungIDMitNullWert'First;
   LeerErforscht : constant Boolean := False;
   LeerAnzahlStädte : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerAnzahlArbeiter : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerAnzahlKämpfer : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerAnzahlSonstiges : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   
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
   
   LeerStädtegrenze : constant EinheitStadtDatentypen.MaximaleStädte := EinheitStadtDatentypen.MaximaleStädte'Last;
   LeerEinheitengrenze : constant EinheitStadtDatentypen.MaximaleEinheiten := EinheitStadtDatentypen.MaximaleEinheiten'Last;
   LeerGeldgrenze : constant Integer := Integer'Last;
   LeerForschungsgrenze : constant EinheitStadtDatentypen.KostenLager:= EinheitStadtDatentypen.KostenLager'Last;
   LeerGeldgewinngrenze : constant EinheitStadtDatentypen.KostenLager := EinheitStadtDatentypen.KostenLager'Last;
   LeerForschungGewinngrenze : constant EinheitStadtDatentypen.KostenLager := EinheitStadtDatentypen.KostenLager'Last;
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
   
   LeerAktuellerZustand : constant SonstigeDatentypen.Status_Untereinander_Enum := SonstigeDatentypen.Unbekannt;
   LeerAktuelleSympathieBewertung : constant EinheitStadtDatentypen.ProduktionFeld := 0;
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
                                                                     GültigeStaatsformen => (SonstigeDatentypen.Anarchie,
                                                                                              SonstigeDatentypen.Anarchie,
                                                                                              SonstigeDatentypen.Anarchie,
                                                                                              SonstigeDatentypen.Anarchie,
                                                                                              SonstigeDatentypen.Anarchie)
                                                                    );

end SonstigesKonstanten;
