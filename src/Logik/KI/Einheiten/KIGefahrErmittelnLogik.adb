with EinheitenDatentypen;
with KartenDatentypen;
with DiplomatieDatentypen;
with KartenKonstanten;

with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseDiplomatie;

with KartenkoordinatenberechnungssystemLogik;
with EinheitSuchenLogik;

with KIDatentypen;

with KIKriegErmittelnLogik;

package body KIGefahrErmittelnLogik is
   
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
              KIKriegErmittelnLogik.IstImKrieg (RasseExtern => EinheitRasseNummerExtern.Rasse) = False
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
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      AktuelleKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
               
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
               
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                              RasseExtern       => EinheitRasseNummerExtern.Rasse)
            then
               null;
                  
            else
               EinheitUnzugeordnet := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert,
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
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type RassenDatentypen.Rassen_Enum;
   begin
      
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
        LeseDiplomatie.AktuellerZustand (RasseEinsExtern => EinheitRasseNummerExtern.Rasse,
                                         RasseZweiExtern => AndereEinheitExtern.Rasse)
      is
         when DiplomatieDatentypen.Krieg_Enum =>
            null;
            
         when others =>
            return False;
      end case;
      
      case
        LeseEinheitenDatenbank.Einheitenart (RasseExtern => AndereEinheitExtern.Rasse,
                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => AndereEinheitExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            return False;
            
         when others =>
            null;
      end case;
      
      return True;
      
   end ReaktionErfoderlich;

end KIGefahrErmittelnLogik;
