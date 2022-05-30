pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with WichtigeRecords;
with KartenRecords;
with StadtDatentypen;
with EinheitenDatentypen;
with SystemDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with ZahlenDatentypen;

with DatenbankRecords;

package WichtigesKonstanten is
   
   LeerCursorGrafik : constant Wide_Wide_Character := '©';
   LeerKoordinaten : constant KartenRecords.AchsenKartenfeldNaturalRecord := (0, 0, 0);
   LeerKoordinatenStadt : constant KartenRecords.AchsenStadtfeldRecord := (1, 1);
   
   LeerCursor : constant KartenRecords.CursorRecord := (
                                                        KoordinatenAktuell => LeerKoordinaten,
                                                        KoordinatenAlt     => LeerKoordinaten,
                                                        KoordinatenStadt   => LeerKoordinatenStadt
                                                       );
   
   LeerGeldmenge : constant ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;
   LeerGeldZugewinnProRunde : constant ProduktionDatentypen.KostenLager := 0;
   LeerGesamteForschungsrate : constant ProduktionDatentypen.KostenLager := 0;
   LeerForschungsmenge : constant ProduktionDatentypen.KostenLager := 0;
   LeerVerbleibendeForschungszeit : constant ProduktionDatentypen.KostenLager := ProduktionDatentypen.KostenLager'Last;
   LeerForschungsprojekt : constant ForschungenDatentypen.ForschungIDMitNullWert := ForschungenDatentypen.ForschungIDMitNullWert'First;
   LeerErforscht : constant Boolean := False;
   LeerAnzahlStädte : constant StadtDatentypen.MaximaleStädteMitNullWert := StadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerAnzahlArbeiter : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerAnzahlKämpfer : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerAnzahlSonstiges : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   
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
   
   LeerStädtegrenze : constant StadtDatentypen.MaximaleStädte := StadtDatentypen.MaximaleStädte'Last;
   LeerEinheitengrenze : constant EinheitenDatentypen.MaximaleEinheiten := EinheitenDatentypen.MaximaleEinheiten'Last;
   LeerGeldgrenze : constant ZahlenDatentypen.EigenerInteger := ZahlenDatentypen.EigenerInteger'Last;
   LeerForschungsgrenze : constant ProduktionDatentypen.KostenLager:= ProduktionDatentypen.KostenLager'Last;
   LeerGeldgewinngrenze : constant ProduktionDatentypen.KostenLager := ProduktionDatentypen.KostenLager'Last;
   LeerForschungGewinngrenze : constant ProduktionDatentypen.KostenLager := ProduktionDatentypen.KostenLager'Last;
   LeerRassenRundengrenze : constant ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;

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
   LeerAktuelleSympathieBewertung : constant ProduktionDatentypen.ProduktionFeld := 0;
   LeerZeitSeitLetzterÄnderung : constant ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;

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
