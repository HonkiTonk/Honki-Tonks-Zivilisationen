with KampfKonstanten;

with LeseGebaeudeDatenbank;

with FeldkampfStadtLogik;
with Kampfgrenzen;

-- Warum übergebe ich hier denn das gesamte Gebäudearray? Das kann man bestimmt auch besser lösen, oder? äöü
-- Wegen dem gleichzeitigen Zugriff von Logik und Grafik, eventuell sollte ich das aufteilen? Ja sollte ich! äöü
-- Eventuell beide Funktionen zusammenführen? äöü
package body KampfwerteStadtErmittelnLogik is

   -- Einwohner * Verbesserung * Basisgrund * Zusatzgrund * Ressource * Fluss * Straße * Gebäudebonus * Feldeffekte
   function AktuelleVerteidigungStadt
     (IDExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeExtern : in StadtArrays.GebäudeArray;
      EinwohnerExtern : in StadtDatentypen.EinwohnerVorhanden)
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      VerteidigungWert := FeldkampfStadtLogik.Feldkampf (KoordinatenExtern    => KoordinatenExtern,
                                                         SpeziesExtern        => SpeziesExtern,
                                                         KampfartExtern       => KampfDatentypen.Verteidigung_Enum,
                                                         KampfBasiswertExtern => KampfDatentypen.KampfwerteGroß (EinwohnerExtern),
                                                         StadttypExtern       => IDExtern);
      
      case
        VerteidigungWert
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
               VerteidigungWert := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => VerteidigungWert,
                                                                     KampfbonusExtern => LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                                                           IDExtern         => GebäudeSchleifenwert,
                                                                                                                           KampfBonusExtern => KampfDatentypen.Verteidigung_Enum));

            when False =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return VerteidigungWert;
      
   end AktuelleVerteidigungStadt;
   
   
   
   -- Einwohner * Verbesserung * Basisgrund * Zusatzgrund * Ressource * Fluss * Straße * Gebäudebonus * Feldeffekte
   function AktuellerAngriffStadt
     (IDExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeExtern : in StadtArrays.GebäudeArray;
      EinwohnerExtern : in StadtDatentypen.EinwohnerVorhanden)
      return KampfDatentypen.KampfwerteGroß
   is begin
            
      AngriffWert := FeldkampfStadtLogik.Feldkampf (KoordinatenExtern    => KoordinatenExtern,
                                                    SpeziesExtern        => SpeziesExtern,
                                                    KampfartExtern       => KampfDatentypen.Angriff_Enum,
                                                    KampfBasiswertExtern => KampfDatentypen.KampfwerteGroß (EinwohnerExtern),
                                                    StadttypExtern       => IDExtern);
      
      case
        AngriffWert
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
               AngriffWert := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => AngriffWert,
                                                                KampfbonusExtern => LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                                                      IDExtern         => GebäudeSchleifenwert,
                                                                                                                      KampfBonusExtern => KampfDatentypen.Angriff_Enum));

            when False =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return AngriffWert;
      
   end AktuellerAngriffStadt;

end KampfwerteStadtErmittelnLogik;
