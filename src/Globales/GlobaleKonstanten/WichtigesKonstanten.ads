pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SpielRecords;
with KartenRecords;
with StadtDatentypen;
with EinheitenDatentypen;
with SystemDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with ZahlenDatentypen;
with KartenRecordKonstanten;

with DatenbankRecords;

package WichtigesKonstanten is
   
   LeerCursorGrafik : constant Wide_Wide_Character := '©';
   
   LeerCursor : constant KartenRecords.CursorRecord := (
                                                        KoordinatenAktuell => KartenRecordKonstanten.LeerKoordinate,
                                                        KoordinatenAlt     => KartenRecordKonstanten.LeerKoordinate,
                                                        KoordinatenStadt   => KartenRecordKonstanten.LeerStadtKoordinate
                                                       );
   
   LeerGeldmenge : constant ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;
   LeerGeldZugewinnProRunde : constant ProduktionDatentypen.Produktion := 0;
   LeerGesamteForschungsrate : constant ProduktionDatentypen.Produktion := 0;
   LeerForschungsmenge : constant ProduktionDatentypen.Produktion := 0;
   LeerVerbleibendeForschungszeit : constant ProduktionDatentypen.Produktion := ProduktionDatentypen.Produktion'Last;
   LeerForschungsprojekt : constant ForschungenDatentypen.ForschungIDMitNullWert := ForschungenDatentypen.ForschungIDMitNullWert'First;
   LeerErforscht : constant Boolean := False;
   LeerAnzahlStädte : constant StadtDatentypen.MaximaleStädteMitNullWert := StadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerAnzahlArbeiter : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerAnzahlKämpfer : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerAnzahlSonstiges : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   
   LeerWichtigesZeug : constant SpielRecords.WichtigesRecord := (
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
   
   LeerStädtegrenze : constant StadtDatentypen.MaximaleStädte := StadtDatentypen.MaximaleStädte'Last;
   LeerEinheitengrenze : constant EinheitenDatentypen.MaximaleEinheiten := EinheitenDatentypen.MaximaleEinheiten'Last;
   LeerGeldgrenze : constant ZahlenDatentypen.EigenerInteger := ZahlenDatentypen.EigenerInteger'Last;
   LeerForschungsgrenze : constant ProduktionDatentypen.Produktion:= ProduktionDatentypen.Produktion'Last;
   LeerGeldgewinngrenze : constant ProduktionDatentypen.Produktion := ProduktionDatentypen.Produktion'Last;
   LeerForschungGewinngrenze : constant ProduktionDatentypen.Produktion := ProduktionDatentypen.Produktion'Last;
   LeerRassenRundengrenze : constant ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;

   LeerGrenzen : constant SpielRecords.GrenzenRecord := (
                                                            Städtegrenze          => LeerStädtegrenze,
                                                            Einheitengrenze       => LeerEinheitengrenze,
                                                            Geldgrenze            => LeerGeldgrenze,
                                                            Forschungsgrenze      => LeerForschungsgrenze,
                                                            Geldgewinngrenze      => LeerGeldgewinngrenze,
                                                            ForschungGewinngrenze => LeerForschungGewinngrenze,
                                                            RassenRundengrenze    => LeerRassenRundengrenze
                                                           );
   
   LeerAktuellerZustand : constant SystemDatentypen.Status_Untereinander_Enum := SystemDatentypen.Unbekannt_Enum;
   LeerAktuelleSympathieBewertung : constant ProduktionDatentypen.Feldproduktion := 0;
   LeerZeitSeitLetzterÄnderung : constant ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;

   LeerDiplomatie : constant SpielRecords.DiplomatieRecord := (
                                                                  AktuellerZustand           => LeerAktuellerZustand,
                                                                  AktuelleSympathieBewertung => LeerAktuelleSympathieBewertung,
                                                                  ZeitSeitLetzterÄnderung    => LeerZeitSeitLetzterÄnderung
                                                                 );
   
   DiplomatischerStatusÄnderungszeit : constant Positive := 10;
   
   -- Wird noch nicht verwendet.
   LeerRassenListe : constant DatenbankRecords.RassenlisteRecord := (
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
