pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with KartenKonstanten;

with Kartenkoordinatenberechnungssystem;
with GrafischeAnzeigeTerminal;
with Sichtweiten;
with KarteInformationenTerminal;

package body KarteTerminal is
   
   procedure AnzeigeKarteTerminal
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtweiten.SichtweiteLesen .. Sichtweiten.SichtweiteLesen loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtweiten.SichtweiteLesen .. Sichtweiten.SichtweiteLesen loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => False);
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  GrafischeAnzeigeTerminal.Sichtbarkeit (InDerStadtExtern  => False,
                                                        KoordinatenExtern => KartenWert,
                                                        RasseExtern       => RasseExtern);
            end case;
            
            NeueZeileKartenform (XAchseExtern => XAchseSchleifenwert);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      New_Line;
      
      KarteInformationenTerminal.KarteInformationenTerminal (RasseExtern => RasseExtern);
      
   end AnzeigeKarteTerminal;
   
   
   
   procedure NeueZeileKartenform
     (XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      if
        XAchseExtern = Sichtweiten.SichtweiteLesen
      then
         if
       --    (Karten.Kartenform = RueckgabeDatentypen.Karte_Form_X_Zylinder_Enum
       --     or
        --      Karten.Kartenform = RueckgabeDatentypen.Karte_Form_Torus_Enum
        --    or
        --      Karten.Kartenform = RueckgabeDatentypen.Karte_Form_Kugel_Enum
       --     or
       --       Karten.Kartenform = RueckgabeDatentypen.Karte_Form_Kugel_Gedreht_Enum
       --     or
       --       Karten.Kartenform = RueckgabeDatentypen.Karte_Form_Tugel_Enum
       --     or
       --       Karten.Kartenform = RueckgabeDatentypen.Karte_Form_Tugel_Gedreht_Enum
       --     or
      --        Karten.Kartenform = RueckgabeDatentypen.Karte_Form_Tugel_Extrem_Enum)
       --    and
             KartenWert.XAchse > KartenKonstanten.LeerXAchse
         then
            New_Line;
                  
      --   elsif
      --     Karten.Kartenform = RueckgabeDatentypen.Karte_Form_Y_Zylinder_Enum
       --    or
      --       Karten.Kartenform = RueckgabeDatentypen.Karte_Form_Viereck_Enum
      --   then
      --      New_Line;
               
         else
            null;
         end if;
                 
      else
         null;
      end if;
      
   end NeueZeileKartenform;

end KarteTerminal;
