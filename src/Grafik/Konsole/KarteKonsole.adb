pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with KartePositionPruefen;
with GrafischeAnzeige;
with Sichtweiten;
with Karten;

package body KarteKonsole is
   
   procedure AnzeigeKarteKonsole
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).YAchse .. Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).XAchse .. Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).XAchse loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  GrafischeAnzeige.Sichtbarkeit (InDerStadtExtern  => False,
                                                 KoordinatenExtern => KartenWert,
                                                 RasseExtern       => RasseExtern);
            end case;
            
            NeueZeileKartenform (XAchseExtern => XAchseSchleifenwert);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      New_Line;
      
   end AnzeigeKarteKonsole;
   
   
   
   procedure NeueZeileKartenform
     (XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      if
        XAchseExtern = Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).XAchse
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
