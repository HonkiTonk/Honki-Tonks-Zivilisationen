with KartenKonstanten;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with StadtKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeWeltkarte;
with SchreibeAllgemeines;
with LeseAllgemeines;

with EinheitenErzeugenEntfernenLogik;
with KartenkoordinatenberechnungssystemLogik;
with StadtEntfernenLogik;
with StadtSuchenLogik;
with EinheitSuchenLogik;

package body PZBEingesetztLogik is

   function PZBEingesetzt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      Einheitenart := LeseEinheitenDatenbank.Einheitenart (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        Einheitenart
      is
         when EinheitenDatentypen.PZB_Enum'Range =>
            SchreibeAllgemeines.AnzahlEingesetzterPZB;
            SchreibeAllgemeines.PlanetVernichtet (RasseExtern => EinheitRasseNummerExtern.Rasse);
            Zusammenbruchszeit := LeseAllgemeines.Zusammenbruchszeit;
            
         when others =>
            return False;
      end case;
      
      case
        Zusammenbruchszeit
      is
         when -1 =>
            if
              LeseWeltkarteneinstellungen.YAchse <= LeseWeltkarteneinstellungen.XAchse
            then
               Zusammenbruchszeit := Natural (abs (LeseWeltkarteneinstellungen.YAchse - Kartengrößen (Einheitenart)) / 10);
                  
            else
               Zusammenbruchszeit := Natural (abs (LeseWeltkarteneinstellungen.XAchse - Kartengrößen (Einheitenart)) / 10 );
            end if;
               
         when others =>
            EingesetztePZB := LeseAllgemeines.AnzahlEingesetzterPZB;
            
            if
              LeseWeltkarteneinstellungen.YAchse <= LeseWeltkarteneinstellungen.XAchse
              and
                Zusammenbruchszeit > Natural (abs (LeseWeltkarteneinstellungen.YAchse - Kartengrößen (Einheitenart)) / 10) / EingesetztePZB
            then
               Zusammenbruchszeit := Natural (abs (LeseWeltkarteneinstellungen.YAchse - Kartengrößen (Einheitenart)) / 10) / EingesetztePZB;
               
            elsif
              LeseWeltkarteneinstellungen.YAchse > LeseWeltkarteneinstellungen.XAchse
              and
                Zusammenbruchszeit > Natural (abs (LeseWeltkarteneinstellungen.XAchse - Kartengrößen (Einheitenart)) / 10) / EingesetztePZB
            then
               Zusammenbruchszeit := Natural (abs (LeseWeltkarteneinstellungen.XAchse - Kartengrößen (Einheitenart)) / 10) / EingesetztePZB;
                  
            else
               null;
            end if;
      end case;
      
      SchreibeAllgemeines.Zusammenbruchszeit (ZeitExtern          => Zusammenbruchszeit,
                                              RechnenSetzenExtern => False);
         
      PlanetenVernichten (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            
      return True;
      
   end PZBEingesetzt;
   
   
   
   procedure PlanetenVernichten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbeneVorhanden'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in -Kartengrößen (Einheitenart) / 2 .. Kartengrößen (Einheitenart) / 2 loop
            XAchseSchleife:
            for XAchseSchleifenwert in -Kartengrößen (Einheitenart) / 2 .. Kartengrößen (Einheitenart) / 2 loop

               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (EAchseSchleifenwert, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               case
                 Kartenwert.EAchse
               is
                  when KartenKonstanten.LeerEAchse =>
                     null;
                     
                  when others =>
                     FeldVernichten (KoordinatenExtern => Kartenwert);
               end case;

            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end PlanetenVernichten;
   
   
   
   -- Hier die Entfernung von Grund/Verbesserungen nicht durch die Platzierungssysteme vornehmen, da ja alles zerstört wird wäre das hier unsinnig.
   procedure FeldVernichten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Einheit := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                       LogikGrafikExtern => True);
      
      case
        Einheit.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            null;
            
         when others =>
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => Einheit);
      end case;
      
      Stadt := StadtSuchenLogik.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
      case
        Stadt.Nummer
      is
         when StadtKonstanten.LeerNummer =>
            null;
            
         when others =>
            StadtEntfernenLogik.StadtEntfernen (StadtRasseNummerExtern => Stadt);
      end case;
      
      SchreibeWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => (KartengrundDatentypen.Vernichtet_Enum, KartengrundDatentypen.Leer_Zusatzgrund_Enum));
      SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                               FlussExtern       => KartengrundDatentypen.Leer_Fluss_Enum);
      SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                             WegExtern         => KartenverbesserungDatentypen.Leer_Weg_Enum);
      SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                      VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
      SchreibeWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern,
                                   RessourceExtern   => KartengrundDatentypen.Leer_Ressource_Enum);
      
   end FeldVernichten;

end PZBEingesetztLogik;
