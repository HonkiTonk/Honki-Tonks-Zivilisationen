pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with DiplomatieDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;

with KIDatentypen;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with Kartenkoordinatenberechnungssystem;
with EinheitSuchen;
with DiplomatischerZustand;

with KIKriegErmitteln;

package body KIGefahrErmitteln is
   
   -- Noch eine Version bauen um die Kampfstärken direkt zu vergleichen? äöü
   function GefahrErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenRecords.RasseEinheitnummerRecord
   is begin
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIDatentypen.Angreifen_Enum | KIDatentypen.Verteidigen_Enum | KIDatentypen.Verbesserung_Zerstören_Enum | KIDatentypen.Flucht_Enum =>
            return EinheitenKonstanten.LeerRasseNummer;
            
         when others =>
            if
              KIKriegErmitteln.IstImKrieg (RasseExtern => EinheitRasseNummerExtern.Rasse) = False
            then
               return EinheitenKonstanten.LeerRasseNummer;
               
            else
               return GefahrSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            end if;
      end case;
            
   end GefahrErmitteln;
   
   
   
   function GefahrSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenRecords.RasseEinheitnummerRecord
   is begin
      
      AktuelleKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
               
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinaten,
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
               
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseKarten.Sichtbar (KoordinatenExtern => KartenWert,
                                           RasseExtern       => EinheitRasseNummerExtern.Rasse)
            then
               null;
                  
            else
               EinheitUnzugeordnet := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert,
                                                                                       LogikGrafikExtern => True);
                  
               case
                 ReaktionErfoderlich (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      AndereEinheitExtern      => EinheitUnzugeordnet)
               is
                  when False =>
                     null;
                     
                  when True =>
                     return EinheitUnzugeordnet;
               end case;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return EinheitenKonstanten.LeerRasseNummer;
      
   end GefahrSuchen;
   
   
   
   function ReaktionErfoderlich
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AndereEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        AndereEinheitExtern.Nummer = EinheitenKonstanten.LeerNummer
        or
          AndereEinheitExtern.Rasse = EinheitRasseNummerExtern.Rasse
      then
         return False;
         
      else
         null;
      end if;
                     
      case
        DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                           FremdeRasseExtern => AndereEinheitExtern.Rasse)
      is
         when DiplomatieDatentypen.Krieg_Enum =>
            null;
            
         when others =>
            return False;
      end case;
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => AndereEinheitExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => AndereEinheitExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            return False;
            
         when others =>
            null;
      end case;
      
      return True;
      
   end ReaktionErfoderlich;

end KIGefahrErmitteln;
