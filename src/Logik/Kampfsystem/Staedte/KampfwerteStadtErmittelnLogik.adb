with StadtDatentypen;
with KartenKonstanten;

with LeseGebaeudeDatenbank;
with LeseVerbesserungenDatenbank;

with KartenfelderwerteLogik;

-- Warum übergebe ich hier denn das gesamte Gebäudearray? Das kann man bestimmt auch besser lösen, oder? äöü
package body KampfwerteStadtErmittelnLogik is

   function AktuelleVerteidigungStadt
     (IDExtern : in KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeExtern : in StadtArrays.GebäudeArray)
      return KampfDatentypen.KampfwerteGroß
   is
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      VerteidigungWert := LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => IDExtern,
                                                                         SpeziesExtern      => SpeziesExtern,
                                                                         WelcherWertExtern  => KartenKonstanten.KampfVerteidigung)
        + KartenfelderwerteLogik.FeldVerteidigung (KoordinatenExtern => KoordinatenExtern,
                                                   SpeziesExtern     => SpeziesExtern);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           GebäudeExtern (GebäudeSchleifenwert)
         is
            when True =>
               VerteidigungWert := VerteidigungWert + LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                        IDExtern         => GebäudeSchleifenwert,
                                                                                        KampfBonusExtern => KartenKonstanten.KampfVerteidigung);

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
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      AngriffWert := LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => IDExtern,
                                                                    SpeziesExtern      => SpeziesExtern,
                                                                    WelcherWertExtern  => KartenKonstanten.KampfAngriff)
        + KartenfelderwerteLogik.FeldAngriff (KoordinatenExtern => KoordinatenExtern,
                                              SpeziesExtern     => SpeziesExtern);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           GebäudeExtern (GebäudeSchleifenwert)
         is
            when True =>
               AngriffWert := AngriffWert + LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                              IDExtern         => GebäudeSchleifenwert,
                                                                              KampfBonusExtern => KartenKonstanten.KampfAngriff);

            when False =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return AngriffWert;
      
   end AktuellerAngriffStadt;

end KampfwerteStadtErmittelnLogik;
