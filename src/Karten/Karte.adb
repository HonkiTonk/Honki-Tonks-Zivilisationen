pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;

with KartenKonstanten;

with Karten;
with KartePositionPruefen;
with KarteInformationen;
with GrafischeAnzeige;
with KarteAnzeigeErmitteln;
with GrafikAllgemein;

package body Karte is
   
   procedure SichtweiteBewegungsfeldFestlegen
   is begin
      
      case
        Karten.Kartengröße
      is
         when KartenDatentypen.Karte_20_20 =>
            Sichtweiten.SichtweiteFestlegen := 1;
            BewegungsfeldFestlegen := 1;
            
         when KartenDatentypen.Karte_40_40 =>
            Sichtweiten.SichtweiteFestlegen := 2;
            BewegungsfeldFestlegen := 2;

         when KartenDatentypen.Karte_Nutzer =>
            if
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (KartenDatentypen.Karte_20_20).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (KartenDatentypen.Karte_20_20).XAchsenGröße
            then
               Sichtweiten.SichtweiteFestlegen := 1;
               BewegungsfeldFestlegen := 1;
               
            elsif
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (KartenDatentypen.Karte_40_40).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (KartenDatentypen.Karte_40_40).XAchsenGröße
            then
               Sichtweiten.SichtweiteFestlegen := 2;
               BewegungsfeldFestlegen := 2;
               
            else
               Sichtweiten.SichtweiteFestlegen := 3;
               BewegungsfeldFestlegen := 3;
            end if;
            
         when others =>
            Sichtweiten.SichtweiteFestlegen := 3;
            BewegungsfeldFestlegen := 3;
      end case;
      
   end SichtweiteBewegungsfeldFestlegen;
   
   

   procedure AnzeigeKarte
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      CursorPositionAltFestlegen (RasseExtern                  => RasseExtern,
                                  BewegungsfeldFestlegenExtern => BewegungsfeldFestlegen);
      GrafikAllgemein.FensterLeeren;
      
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
            
            KarteAnzeigeErmitteln.Sichtbarkeit (InDerStadtExtern      => False,
                                                SichtweiteEbeneExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                RasseExtern           => RasseExtern);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      New_Line;
      GrafikAllgemein.FensterAnzeigen;
      KarteInformationen.KarteInformation (RasseExtern => RasseExtern);

   end AnzeigeKarte;
   
   
   
   procedure NeueZeileKartenform
     (XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      if
        XAchseExtern = Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).XAchse
      then
         if
           (Karten.Kartenform = KartenDatentypen.X_Zylinder
            or
              Karten.Kartenform = KartenDatentypen.Torus
            or
              Karten.Kartenform = KartenDatentypen.Kugel
            or
              Karten.Kartenform = KartenDatentypen.Kugel_Gedreht
            or
              Karten.Kartenform = KartenDatentypen.Tugel
            or
              Karten.Kartenform = KartenDatentypen.Tugel_Gedreht
            or
              Karten.Kartenform = KartenDatentypen.Tugel_Extrem)
           and
             KartenWert.XAchse > KartenKonstanten.LeerXAchse
         then
            New_Line;
                  
         elsif
           Karten.Kartenform = KartenDatentypen.Y_Zylinder
           or
             Karten.Kartenform = KartenDatentypen.Viereck
         then
            New_Line;
               
         else
            null;
         end if;
                 
      else
         null;
      end if;
      
   end NeueZeileKartenform;
   
   
   
   procedure CursorPositionAltFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
   is begin
      
      AlteEAchseFestlegen (RasseExtern => RasseExtern);
      AlteYAchseFestlegen (RasseExtern                  => RasseExtern,
                           BewegungsfeldFestlegenExtern => BewegungsfeldFestlegenExtern);
      AlteXAchseFestlegen (RasseExtern                  => RasseExtern,
                           BewegungsfeldFestlegenExtern => BewegungsfeldFestlegenExtern);
      
   end CursorPositionAltFestlegen;
   
   
   
   procedure AlteEAchseFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.EAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse
      then
         null;
            
      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse;
      end if;
      
   end AlteEAchseFestlegen;
   
   
   
   procedure AlteYAchseFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse
           > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse;
            
         else
            null;
         end if;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse < Karten.WeltkarteArray'First (2)
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse
           < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse;
            
         else
            null;
         end if;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
           or
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse;
            
         else
            null;
         end if;
      end if;
      
   end AlteYAchseFestlegen;
   
   
   
   procedure AlteXAchseFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse
           > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse;
            
         else
            null;
         end if;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse < Karten.WeltkarteArray'First (3)
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse
           < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse;
            
         else
            null;
         end if;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           or
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse;
            
         else
            null;
         end if;
      end if;
      
   end AlteXAchseFestlegen;
   
end Karte;
