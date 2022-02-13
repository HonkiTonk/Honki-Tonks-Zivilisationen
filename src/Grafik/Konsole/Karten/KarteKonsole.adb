pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with KarteKoordinatenPruefen;
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
            
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                           ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                           LogikGrafikExtern => False);
            
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
           (Karten.Kartenform = KartenKonstanten.KartenformXZylinderKonstante
            or
              Karten.Kartenform = KartenKonstanten.KartenformTorusKonstante
            or
              Karten.Kartenform = KartenKonstanten.KartenformKugelKonstante
            or
              Karten.Kartenform = KartenKonstanten.KartenformKugelGedrehtKonstante
            or
              Karten.Kartenform = KartenKonstanten.KartenformTugelKonstante
            or
              Karten.Kartenform = KartenKonstanten.KartenformTugelGedrehtKonstante
            or
              Karten.Kartenform = KartenKonstanten.KartenformTugelExtremKonstante)
           and
             KartenWert.XAchse > KartenKonstanten.LeerXAchse
         then
            New_Line;
                  
         elsif
           Karten.Kartenform = KartenKonstanten.KartenformYZylinderKonstante
           or
             Karten.Kartenform = KartenKonstanten.KartenformViereckKonstante
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
