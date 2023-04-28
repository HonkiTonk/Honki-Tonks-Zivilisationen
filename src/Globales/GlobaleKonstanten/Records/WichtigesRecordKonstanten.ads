with KartenRecords;
with KartenRecordKonstanten;
with SpielRecords;
with WichtigesKonstanten;
with SpielDatentypen;
with TextKonstanten;
with SpeziesDatentypen;
with DatenbankRecords;
with SpeziesKonstanten;

package WichtigesRecordKonstanten is
   pragma Elaborate_Body;

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
                                                                 Gewonnen              => False,
                                                                 Weiterspielen         => False,
                                                                 SpeziesAmZugNachLaden   => SpeziesKonstanten.LeerSpezies,
                                                                 -- Das auslagern damit man es nicht immer neu setzen muss? äöü
                                                                 Schwierigkeitsgrad    => SpielDatentypen.Schwierigkeitsgrad_Leicht_Enum,
                                                                 Rundenanzahl          => Positive'First,
                                                                 -- Das auslagern damit man es nicht immer neu setzen muss? äöü
                                                                 Rundengrenze          => Natural'First,
                                                                 IronmanName           => TextKonstanten.LeerUnboundedString,
                                                                 PlanetVernichtet      => SpeziesKonstanten.LeerSpezies,
                                                                 Zusammenbruchszeit    => WichtigesKonstanten.KeinZusammenbruch,
                                                                 AnzahlEingesetzterPZB => 0
                                                                );
   
   LeerGrenzen : constant SpielRecords.GrenzenRecord := (
                                                         Städtegrenze          => WichtigesKonstanten.LeerStädtegrenze,
                                                         Einheitengrenze       => WichtigesKonstanten.LeerEinheitengrenze,
                                                         Geldgrenze            => WichtigesKonstanten.LeerGeldgrenze,
                                                         Forschungsgrenze      => WichtigesKonstanten.LeerForschungsgrenze,
                                                         Geldgewinngrenze      => WichtigesKonstanten.LeerGeldgewinngrenze,
                                                         ForschungGewinngrenze => WichtigesKonstanten.LeerForschungGewinngrenze,
                                                         SpeziesRundengrenze    => WichtigesKonstanten.LeerSpeziesRundengrenze
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
   
   LeerSpeziesbelegung : constant SpielRecords.SpeziesRecords := (
                                                                  Belegung => SpeziesDatentypen.Leer_Spieler_Enum,
                                                                  Besiegt  => False
                                                                 );
   
   -- Wird noch nicht verwendet. Wird das jemals sinnvoll sein? äöü
   LeerSpeziesListe : constant DatenbankRecords.SpezieslisteRecord := (
                                                                       Aggressivität       => 1,
                                                                       Expansion           => 1,
                                                                       Wissenschaft        => 1,
                                                                       Produktion          => 1,
                                                                       Wirtschaft          => 1,
                                                                       Bewirtschaftung     => 1,
                                                                       Staatsformen        =>
                                                                         (
                                                                          SpeziesDatentypen.Anarchie_Enum,
                                                                          SpeziesDatentypen.Anarchie_Enum,
                                                                          SpeziesDatentypen.Anarchie_Enum,
                                                                          SpeziesDatentypen.Anarchie_Enum,
                                                                          SpeziesDatentypen.Anarchie_Enum
                                                                         )
                                                                      );
   
end WichtigesRecordKonstanten;
