pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenRecordKonstanten;
with SpielRecords;
with WichtigesKonstanten;
with EinheitenKonstanten;
with SpielDatentypen;
with TextKonstanten;
with RassenDatentypen;

with DatenbankRecords;

package WichtigesRecordKonstanten is

   LeerCursor : constant KartenRecords.CursorRecord := (
                                                        KoordinatenAktuell => KartenRecordKonstanten.LeerKoordinate,
                                                        KoordinatenAlt     => KartenRecordKonstanten.LeerKoordinate
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
                                                                 -- Das auslagern damit man es nicht immer neu setzen muss? äöü
                                                                 Schwierigkeitsgrad  => SpielDatentypen.Schwierigkeitsgrad_Leicht_Enum,
                                                                 Rundenanzahl        => Positive'First,
                                                                  -- Das auslagern damit man es nicht immer neu setzen muss? äöü
                                                                 Rundengrenze        => Natural'First,
                                                                 IronmanName         => TextKonstanten.LeerUnboundedString,
                                                                 PlanetVernichtet    => RassenDatentypen.Keine_Rasse_Enum,
                                                                 Zusammenbruchszeit  => -1
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
   
   StartDiplomatie : constant SpielRecords.DiplomatieRecord := (
                                                                AktuellerZustand           => WichtigesKonstanten.LeerAktuellerZustand,
                                                                AktuelleSympathieBewertung => WichtigesKonstanten.LeerAktuelleSympathieBewertung,
                                                                ZeitSeitLetzterÄnderung    => WichtigesKonstanten.DiplomatischerStatusÄnderungszeit
                                                               );
   
   LeerRassenbelegung : constant SpielRecords.RassenRecords := (
                                                                Belegung => RassenDatentypen.Leer_Spieler_Enum,
                                                                Besiegt  => False
                                                               );
   
   -- Wird noch nicht verwendet. Wird das jemals sinnvoll sein? äöü
   LeerRassenListe : constant DatenbankRecords.RassenlisteRecord := (
                                                                     Aggressivität       => 0,
                                                                     Expansion           => 0,
                                                                     Wissenschaft        => 0,
                                                                     Produktion          => 0,
                                                                     Wirtschaft          => 0,
                                                                     Bewirtschaftung     => 0,
                                                                     Staatsformen        =>
                                                                       (
                                                                        RassenDatentypen.Anarchie_Enum,
                                                                        RassenDatentypen.Anarchie_Enum,
                                                                        RassenDatentypen.Anarchie_Enum,
                                                                        RassenDatentypen.Anarchie_Enum,
                                                                        RassenDatentypen.Anarchie_Enum
                                                                       )
                                                                    );
   
end WichtigesRecordKonstanten;
