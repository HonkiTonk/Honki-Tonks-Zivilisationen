pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenRecordKonstanten;
with SpielRecords;
with WichtigesKonstanten;
with SystemDatentypen;
with EinheitenKonstanten;
with SpielDatentypen;
with TextKonstanten;

with DatenbankRecords;

package WichtigesRecordKonstanten is

   LeerCursor : constant KartenRecords.CursorRecord := (
                                                        KoordinatenAktuell => KartenRecordKonstanten.LeerKoordinate,
                                                        KoordinatenAlt     => KartenRecordKonstanten.LeerKoordinate,
                                                        KoordinatenStadt   => KartenRecordKonstanten.LeerStadtKoordinate
                                                       );
   
   LeerWichtigesZeug : constant SpielRecords.WichtigesRecord := (
                                                                 Geldmenge                  => WichtigesKonstanten.LeerGeldmenge,
                                                                 GeldZugewinnProRunde       => WichtigesKonstanten.LeerGeldZugewinnProRunde,
                                                                 GesamteForschungsrate      => WichtigesKonstanten.LeerGesamteForschungsrate,
                                                                 Forschungsmenge            => WichtigesKonstanten.LeerForschungsmenge,
                                                                 VerbleibendeForschungszeit => WichtigesKonstanten.LeerVerbleibendeForschungszeit,
                                                                 Forschungsprojekt          => WichtigesKonstanten.LeerForschungsprojekt,
                                                                 Erforscht                  => (others => WichtigesKonstanten.LeerErforscht),
                                                                 AnzahlStädte               => WichtigesKonstanten.LeerAnzahlStädte,
                                                                 AnzahlArbeiter             => WichtigesKonstanten.LeerAnzahlArbeiter,
                                                                 AnzahlKämpfer              => WichtigesKonstanten.LeerAnzahlKämpfer,
                                                                 AnzahlSonstiges            => WichtigesKonstanten.LeerAnzahlSonstiges
                                                                );
  
   LeerAllgemeines : constant SpielRecords.AllgemeinesRecord := (
                                                                 Gewonnen            => False,
                                                                 Weiterspielen       => False,
                                                                 RasseAmZugNachLaden => EinheitenKonstanten.LeerRasse,
                                                                 Schwierigkeitsgrad  => SpielDatentypen.Schwierigkeitsgrad_Leicht_Enum,
                                                                 Rundenanzahl        => Positive'First,
                                                                 Rundengrenze        => Natural'First,   
                                                                 IronmanName         => TextKonstanten.LeerUnboundedString
                                                                );
   
   LeerGrenzen : constant SpielRecords.GrenzenRecord := (
                                                         Städtegrenze          => WichtigesKonstanten.LeerStädtegrenze,
                                                         Einheitengrenze       => WichtigesKonstanten.LeerEinheitengrenze,
                                                         Geldgrenze            => WichtigesKonstanten.LeerGeldgrenze,
                                                         Forschungsgrenze      => WichtigesKonstanten.LeerForschungsgrenze,
                                                         Geldgewinngrenze      => WichtigesKonstanten.LeerGeldgewinngrenze,
                                                         ForschungGewinngrenze => WichtigesKonstanten.LeerForschungGewinngrenze,
                                                         RassenRundengrenze    => WichtigesKonstanten.LeerRassenRundengrenze
                                                        );
   
   LeerDiplomatie : constant SpielRecords.DiplomatieRecord := (
                                                               AktuellerZustand           => WichtigesKonstanten.LeerAktuellerZustand,
                                                               AktuelleSympathieBewertung => WichtigesKonstanten.LeerAktuelleSympathieBewertung,
                                                               ZeitSeitLetzterÄnderung    => WichtigesKonstanten.LeerZeitSeitLetzterÄnderung
                                                              );
   
   ---------------------------------- Wird noch nicht verwendet. Wird das jemals sinnvoll sein?
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
   
end WichtigesRecordKonstanten;