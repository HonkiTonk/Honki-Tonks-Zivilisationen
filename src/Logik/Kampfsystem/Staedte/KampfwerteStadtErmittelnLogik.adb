with KampfKonstanten;

with LeseGebaeudeDatenbank;

with FeldkampfStadtLogik;
with Kampfgrenzen;

-- Ich übergebe hier das gesamte Gebäudearray damit es bei Änderungen durch die Logik keine Probleme mit der Grafik gibt. Kann man das auch besser lösen? äöü
-- Eventuell beide Funktionen zusammenführen? äöü
-- Bonus auf Basis der Stadtgröße einbauen? äöü
package body KampfwerteStadtErmittelnLogik is

   -- Einwohner * Verbesserung * Basisgrund * Zusatzgrund * Ressource * Fluss * Straße * Gebäudebonus * Feldeffekte
   function AktuelleVerteidigungStadt
     (IDExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeExtern : in StadtArrays.GebäudeArray;
      EinwohnerExtern : in StadtDatentypen.EinwohnerVorhanden;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      Verteidigung (TaskExtern) := FeldkampfStadtLogik.Feldkampf (KoordinatenExtern    => KoordinatenExtern,
                                                                  SpeziesExtern        => SpeziesExtern,
                                                                  KampfartExtern       => KampfDatentypen.Verteidigung_Enum,
                                                                  KampfBasiswertExtern => KampfDatentypen.KampfwerteGroß (EinwohnerExtern),
                                                                  StadttypExtern       => IDExtern,
                                                                  TaskExtern    => TaskExtern);
      
      case
        Verteidigung (TaskExtern)
      is
         when KampfKonstanten.LeerKampfwert =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            null;
      end case;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GebäudeExtern'Range loop
         
         case
           GebäudeExtern (GebäudeSchleifenwert)
         is
            when True =>
               Verteidigung (TaskExtern) := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Verteidigung (TaskExtern),
                                                                              KampfbonusExtern => LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                                                                    IDExtern         => GebäudeSchleifenwert,
                                                                                                                                    KampfBonusExtern => KampfDatentypen.Verteidigung_Enum));

            when False =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return Verteidigung (TaskExtern);
      
   end AktuelleVerteidigungStadt;
   
   
   
   -- Einwohner * Verbesserung * Basisgrund * Zusatzgrund * Ressource * Fluss * Straße * Gebäudebonus * Feldeffekte
   function AktuellerAngriffStadt
     (IDExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeExtern : in StadtArrays.GebäudeArray;
      EinwohnerExtern : in StadtDatentypen.EinwohnerVorhanden;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KampfDatentypen.KampfwerteGroß
   is begin
            
      Angriff (TaskExtern) := FeldkampfStadtLogik.Feldkampf (KoordinatenExtern    => KoordinatenExtern,
                                                             SpeziesExtern        => SpeziesExtern,
                                                             KampfartExtern       => KampfDatentypen.Angriff_Enum,
                                                             KampfBasiswertExtern => KampfDatentypen.KampfwerteGroß (EinwohnerExtern),
                                                             StadttypExtern       => IDExtern,
                                                             TaskExtern    => TaskExtern);
      
      case
        Angriff (TaskExtern)
      is
         when KampfKonstanten.LeerKampfwert =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            null;
      end case;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GebäudeExtern'Range loop
         
         case
           GebäudeExtern (GebäudeSchleifenwert)
         is
            when True =>
               Angriff (TaskExtern) := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => Angriff (TaskExtern),
                                                                         KampfbonusExtern => LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                                                               IDExtern         => GebäudeSchleifenwert,
                                                                                                                               KampfBonusExtern => KampfDatentypen.Angriff_Enum));

            when False =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return Angriff (TaskExtern);
      
   end AktuellerAngriffStadt;

end KampfwerteStadtErmittelnLogik;
