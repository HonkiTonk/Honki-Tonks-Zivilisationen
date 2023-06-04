with StadtDatentypen;
with KartenKonstanten;

with LeseGebaeudeDatenbank;
with LeseVerbesserungenDatenbank;

with FeldkampfStadtLogik;
with Kampfgrenzen;

-- Warum übergebe ich hier denn das gesamte Gebäudearray? Das kann man bestimmt auch besser lösen, oder? äöü
-- Die Verberessung für die Stadt nur bei Einheiten berücksichtigen und für die Städte einen eigenen Wert einbauen? äöü
-- Eventuell die Einwohner dafür hernehmen? Als Kampfkraft und Lebenspunkte? äöü
package body KampfwerteStadtErmittelnLogik is

   function AktuelleVerteidigungStadt
     (IDExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeExtern : in StadtArrays.GebäudeArray)
      return KampfDatentypen.KampfwerteGroß
   is
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      -- Grundwert ist (Stadttyp + Basisgrund + Zusatzgrund + Ressource + Fluss + Straße) * Gebäudebonus * Feldeffekte
      VerteidigungWert := LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => IDExtern,
                                                                         SpeziesExtern      => SpeziesExtern,
                                                                         KampfartExtern     => KartenKonstanten.KampfVerteidigung)
        + FeldkampfStadtLogik.Feldkampf (KoordinatenExtern => KoordinatenExtern,
                                         SpeziesExtern     => SpeziesExtern,
                                         KampfartExtern    => KampfDatentypen.Verteidigung_Enum);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           GebäudeExtern (GebäudeSchleifenwert)
         is
            when True =>
               VerteidigungWert := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => VerteidigungWert,
                                                                     KampfbonusExtern => LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                                                           IDExtern         => GebäudeSchleifenwert,
                                                                                                                           KampfBonusExtern => KartenKonstanten.KampfVerteidigung));

            when False =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => VerteidigungWert,
                                               KampfbonusExtern => FeldkampfStadtLogik.FeldeffektemalusFestlegen (KoordinatenExtern => KoordinatenExtern,
                                                                                                                  SpeziesExtern     => SpeziesExtern,
                                                                                                                  KampfartExtern    => KartenKonstanten.KampfVerteidigung));
      
   end AktuelleVerteidigungStadt;
   
   
   
   function AktuellerAngriffStadt
     (IDExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeExtern : in StadtArrays.GebäudeArray)
      return KampfDatentypen.KampfwerteGroß
   is
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      -- Grundwert ist (Stadttyp + Basisgrund + Zusatzgrund + Ressource + Fluss + Straße) * Gebäudebonus * Feldeffekte
      AngriffWert := LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => IDExtern,
                                                                    SpeziesExtern      => SpeziesExtern,
                                                                    KampfartExtern     => KartenKonstanten.KampfAngriff)
        + FeldkampfStadtLogik.Feldkampf (KoordinatenExtern => KoordinatenExtern,
                                         SpeziesExtern     => SpeziesExtern,
                                         KampfartExtern    => KampfDatentypen.Angriff_Enum);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           GebäudeExtern (GebäudeSchleifenwert)
         is
            when True =>
               AngriffWert := Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => AngriffWert,
                                                                KampfbonusExtern => LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                                                      IDExtern         => GebäudeSchleifenwert,
                                                                                                                      KampfBonusExtern => KartenKonstanten.KampfAngriff));

            when False =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return Kampfgrenzen.KampfwertKampfbonus (KampfwertExtern  => AngriffWert,
                                               KampfbonusExtern => FeldkampfStadtLogik.FeldeffektemalusFestlegen (KoordinatenExtern => KoordinatenExtern,
                                                                                                                  SpeziesExtern     => SpeziesExtern,
                                                                                                                  KampfartExtern    => KartenKonstanten.KampfAngriff));
      
   end AktuellerAngriffStadt;

end KampfwerteStadtErmittelnLogik;
