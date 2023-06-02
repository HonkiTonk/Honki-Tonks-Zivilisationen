with StadtDatentypen;
with KartenKonstanten;

with LeseGebaeudeDatenbank;
-- with LeseVerbesserungenDatenbank;

with FeldkampfStadtLogik;

-- Warum übergebe ich hier denn das gesamte Gebäudearray? Das kann man bestimmt auch besser lösen, oder? äöü
package body KampfwerteStadtErmittelnLogik is

   function AktuelleVerteidigungStadt
     (IDExtern : in KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeExtern : in StadtArrays.GebäudeArray)
      return KampfDatentypen.KampfwerteGroß
   is
      -- use type KampfDatentypen.KampfwerteGroß;
   begin
      
      VerteidigungWert := -- LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => IDExtern,
                          --                                               SpeziesExtern      => SpeziesExtern,
                          --                                               KampfartExtern     => KartenKonstanten.KampfVerteidigung)
         FeldkampfStadtLogik.Feldkampf (KoordinatenExtern => KoordinatenExtern,
                                         SpeziesExtern     => SpeziesExtern,
                                         KampfartExtern    => KampfDatentypen.Verteidigung_Enum);
      
      case
        IDExtern
      is
         when others =>
            null;
      end case;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           GebäudeExtern (GebäudeSchleifenwert)
         is
            when True =>
               VerteidigungWert := KampfDatentypen.KampfwerteGroß (Float (VerteidigungWert) * Float (LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                                                                        IDExtern         => GebäudeSchleifenwert,
                                                                                                                                        KampfBonusExtern => KartenKonstanten.KampfVerteidigung)));

            when False =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return VerteidigungWert;
      
   end AktuelleVerteidigungStadt;
   
   
   
   function AktuellerAngriffStadt
     (IDExtern : in KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeExtern : in StadtArrays.GebäudeArray)
      return KampfDatentypen.KampfwerteGroß
   is
      -- use type KampfDatentypen.KampfwerteGroß;
   begin
      
      AngriffWert := FeldkampfStadtLogik.Feldkampf (KoordinatenExtern => KoordinatenExtern,
                                               SpeziesExtern     => SpeziesExtern,
                                               KampfartExtern    => KampfDatentypen.Angriff_Enum);
      
      -- LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => IDExtern,
      --                                                            SpeziesExtern      => SpeziesExtern,
      --                                                            WelcherWertExtern  => KartenKonstanten.KampfAngriff);
      
      case
        IDExtern
      is
         when others =>
            null;
      end case;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           GebäudeExtern (GebäudeSchleifenwert)
         is
            when True =>
               AngriffWert := KampfDatentypen.KampfwerteGroß (Float (AngriffWert) + Float (LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                                                              IDExtern         => GebäudeSchleifenwert,
                                                                                                                              KampfBonusExtern => KartenKonstanten.KampfAngriff)));

            when False =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return AngriffWert;
      
   end AktuellerAngriffStadt;

end KampfwerteStadtErmittelnLogik;
