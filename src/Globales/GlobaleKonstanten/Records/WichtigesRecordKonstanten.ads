with TextKonstantenHTSEB;

with KartenRecords;
with KartenRecordKonstanten;
with SpielRecords;
with WichtigesKonstanten;
with SpielDatentypen;
with SpeziesDatentypen;
with SpeziesKonstanten;

package WichtigesRecordKonstanten is
   pragma Elaborate_Body;

   LeerZeiger : constant KartenRecords.ZeigerRecord := (
                                                        KoordinatenAktuell => KartenRecordKonstanten.LeerKoordinate,
                                                        KoordinatenAlt     => KartenRecordKonstanten.LeerKoordinate
                                                       );
   
   LeerWichtigesZeug : constant SpielRecords.WichtigesRecord := (
                                                                 Geldmenge                  => WichtigesKonstanten.LeerGeldmenge,
                                                                 GeldRundengewinn           => WichtigesKonstanten.LeerGeldZugewinnProRunde,
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
                                                                 SpezieszugNachLaden => SpeziesKonstanten.LeerSpezies,
                                                                 Schwierigkeitsgrad  => SpielDatentypen.Schwierigkeitsgrad_Leicht_Enum,
                                                                 Rundenanzahl        => Positive'First,
                                                                 Rundengrenze        => Natural'First,
                                                                 IronmanName         => TextKonstantenHTSEB.LeerUnboundedString,
                                                                 PlanetVernichtet    => SpeziesKonstanten.LeerSpezies,
                                                                 Zusammenbruchszeit  => WichtigesKonstanten.KeinZusammenbruch,
                                                                 EingesetztePZB      => 0
                                                                );
   
   LeerGrenzen : constant SpielRecords.GrenzenRecord := (
                                                         Städtegrenze          => WichtigesKonstanten.LeerStädtegrenze,
                                                         Einheitengrenze       => WichtigesKonstanten.LeerEinheitengrenze,
                                                         Geldgrenze            => WichtigesKonstanten.LeerGeldgrenze,
                                                         Forschungsgrenze      => WichtigesKonstanten.LeerForschungsgrenze,
                                                         Geldgewinngrenze      => WichtigesKonstanten.LeerGeldgewinngrenze,
                                                         ForschungGewinngrenze => WichtigesKonstanten.LeerForschungGewinngrenze,
                                                         SpeziesRundengrenze   => WichtigesKonstanten.LeerSpeziesRundengrenze
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
   
end WichtigesRecordKonstanten;
