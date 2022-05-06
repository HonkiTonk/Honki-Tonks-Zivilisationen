pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with WichtigeRecords;
with KartenRecords;
with EinheitStadtDatentypen;
with SystemDatentypen;
with ForschungenDatentypen;

with DatenbankRecords;

package WichtigesKonstanten is
   
   LeerCursorGrafik : constant Wide_Wide_Character := '©';
   LeerKoordinaten : constant KartenRecords.AchsenKartenfeldPositivRecord := (0, 0, 0);
   LeerKoordinatenStadt : constant KartenRecords.AchsenStadtfeldRecord := (1, 1);
   
   LeerCursor : constant KartenRecords.CursorRecord := (
                                                        KoordinatenAktuell => LeerKoordinaten,
                                                        KoordinatenAlt     => LeerKoordinaten,
                                                        KoordinatenStadt   => LeerKoordinatenStadt
                                                       );
   
   LeerGeldmenge : constant Integer := 100;
   LeerGeldZugewinnProRunde : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerGesamteForschungsrate : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerForschungsmenge : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerVerbleibendeForschungszeit : constant EinheitStadtDatentypen.KostenLager := EinheitStadtDatentypen.KostenLager'Last;
   LeerForschungsprojekt : constant ForschungenDatentypen.ForschungIDMitNullWert := ForschungenDatentypen.ForschungIDMitNullWert'First;
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
   
   LeerAktuellerZustand : constant SystemDatentypen.Status_Untereinander_Enum := SystemDatentypen.Unbekannt_Enum;
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
                                                                     GültigeStaatsformen =>
                                                                       (
                                                                        SystemDatentypen.Anarchie_Enum,
                                                                        SystemDatentypen.Anarchie_Enum,
                                                                        SystemDatentypen.Anarchie_Enum,
                                                                        SystemDatentypen.Anarchie_Enum,
                                                                        SystemDatentypen.Anarchie_Enum
                                                                       )
                                                                    );

end WichtigesKonstanten;
