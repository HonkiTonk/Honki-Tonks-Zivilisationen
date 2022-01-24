pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with KartePositionPruefen;
with GrafischeAnzeigeKonsole;
with Sichtweiten;
with Karten;
with KarteInformationenKonsole;

package body KarteKonsole is
   
   procedure AnzeigeKarteKonsole
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => True) .. Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => True) loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => False) .. Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => False) loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  GrafischeAnzeigeKonsole.Sichtbarkeit (InDerStadtExtern  => False,
                                                        KoordinatenExtern => KartenWert,
                                                        RasseExtern       => RasseExtern);
            end case;
            
            NeueZeileKartenform (XAchseExtern => XAchseSchleifenwert);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      New_Line;
      
      KarteInformationenKonsole.KarteInformationenKonsole (RasseExtern => RasseExtern);
      
   end AnzeigeKarteKonsole;
   
   
   
   procedure NeueZeileKartenform
     (XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      if
        XAchseExtern = Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => False)
      then
         if
           (Karten.Kartenform = SystemDatentypen.Karte_Form_X_Zylinder
            or
              Karten.Kartenform = SystemDatentypen.Karte_Form_Torus
            or
              Karten.Kartenform = SystemDatentypen.Karte_Form_Kugel
            or
              Karten.Kartenform = SystemDatentypen.Karte_Form_Kugel_Gedreht
            or
              Karten.Kartenform = SystemDatentypen.Karte_Form_Tugel
            or
              Karten.Kartenform = SystemDatentypen.Karte_Form_Tugel_Gedreht
            or
              Karten.Kartenform = SystemDatentypen.Karte_Form_Tugel_Extrem)
           and
             KartenWert.XAchse > KartenKonstanten.LeerXAchse
         then
            New_Line;
                  
         elsif
           Karten.Kartenform = SystemDatentypen.Karte_Form_Y_Zylinder
           or
             Karten.Kartenform = SystemDatentypen.Karte_Form_Viereck
         then
            New_Line;
               
         else
            null;
         end if;
                 
      else
         null;
      end if;
      
   end NeueZeileKartenform;

end KarteKonsole;
