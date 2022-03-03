pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;

with KIDatentypen;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with KarteKoordinatenPruefen;
with EinheitSuchen;
with DiplomatischerZustand;

package body KIGefahrErmitteln is
   
   function GefahrErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
   is begin
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIDatentypen.Angreifen | KIDatentypen.Verteidigen | KIDatentypen.Verbesserung_Zerstören | KIDatentypen.Flucht =>
            return EinheitenKonstanten.LeerRasseNummer;
            
         when others =>
            return GefahrSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
            
   end GefahrErmitteln;
   
   
   
   function GefahrSuchen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
               
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                           ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                           LogikGrafikExtern => True);
               
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Sichtbar (KoordinatenExtern => KartenWert,
                                   RasseExtern       => EinheitRasseNummerExtern.Rasse)
              = False
            then
               null;
                  
            else
               EinheitUnzugeordnet := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert);
                  
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AndereEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if
        AndereEinheitExtern.Platznummer = EinheitenKonstanten.LeerNummer
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
         when SystemDatentypen.Krieg =>
            null;
            
         when others =>
            return False;
      end case;
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => AndereEinheitExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => AndereEinheitExtern))
      is
         when EinheitStadtDatentypen.Arbeiter =>
            return False;
            
         when others =>
            null;
      end case;
      
      return True;
      
   end ReaktionErfoderlich;

end KIGefahrErmitteln;
