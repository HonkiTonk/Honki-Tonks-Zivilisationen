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

with LeseKIVariablen;

package body KIGefahrErmittelnLogik is
   
   -- Noch eine Version bauen um die Kampfstärken direkt zu vergleichen? äöü
   -- Diese function kann vermutlich später raus? äöü
   function GefahrErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.SpeziesEinheitnummerRecord
   is begin
      
      if
        LeseKIVariablen.Kriegszustand = False
      then
         return EinheitenKonstanten.LeerEinheit;
         
      else
         case
           LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
         is
            when KIDatentypen.Angreifen_Enum | KIDatentypen.Verteidigen_Enum | KIDatentypen.Verbesserung_Zerstören_Enum | KIDatentypen.Flucht_Enum =>
               return EinheitenKonstanten.LeerEinheit;
            
            when others =>
               return GefahrSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         end case;
      end if;
            
   end GefahrErmitteln;
   
   
   
   -- Den Bereich eventuell vergrößern? Gibt später ja auch Einheiten mit größerem Bewegungsradius. äöü
   function GefahrSuchen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.SpeziesEinheitnummerRecord
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      AktuelleKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
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
                                              SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies)
            then
               null;
                  
            else
               EinheitUnzugeordnet := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => KartenWert,
                                                                                              LogikGrafikExtern => True);
                  
               case
                 ReaktionErfoderlich (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                      AndereEinheitExtern        => EinheitUnzugeordnet)
               is
                  when False =>
                     null;
                     
                  when True =>
                     return EinheitUnzugeordnet;
               end case;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return EinheitenKonstanten.LeerEinheit;
      
   end GefahrSuchen;
   
   
   
   function ReaktionErfoderlich
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AndereEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      if
        AndereEinheitExtern.Nummer = EinheitenKonstanten.LeerNummer
        or
          AndereEinheitExtern.Spezies = EinheitSpeziesNummerExtern.Spezies
      then
         return False;
         
      else
         null;
      end if;
                     
      case
        LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => EinheitSpeziesNummerExtern.Spezies,
                                         SpeziesZweiExtern => AndereEinheitExtern.Spezies)
      is
         when DiplomatieDatentypen.Krieg_Enum =>
            null;
            
         when others =>
            return False;
      end case;
      
      case
        LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => AndereEinheitExtern.Spezies,
                                             IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => AndereEinheitExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            return False;
            
         when others =>
            return True;
      end case;
            
   end ReaktionErfoderlich;

end KIGefahrErmittelnLogik;
