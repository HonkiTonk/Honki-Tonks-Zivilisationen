pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;

with GrafikEinstellungen;
with AllgemeineTextBerechnungenSFML;

package body AuswahlSpracheAnzeige is
   
   procedure AnzeigeSpracheSFML
   is begin
      
      MehrereSeiten := AuswahlSprache.MehrereSeiten;
      AktuelleAuswahl := AuswahlSprache.AktuelleAuswahl;
      Ende := AuswahlSprache.Ende;
      AktuelleSprachen := AuswahlSprache.AktuelleSprachen;
      ZeilenAbstand := Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße) * 0.15;
      Sf.Graphics.Text.setFont (text => TextAccess,
                                font => GrafikEinstellungen.Schriftart);
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
      YPosition := StartPositionYAchse;
            
      AnzeigeSchleife:
      for ZeileSchleifenwert in AktuelleSprachen'First .. Ende loop
         
         if
           AktuelleAuswahl = ZeileSchleifenwert
         then
            AktuelleTextFarbe := GrafikEinstellungen.Schriftfarben.FarbeAusgewähltText;
            
         else
            AktuelleTextFarbe := GrafikEinstellungen.Schriftfarben.FarbeStandardText;
         end if;
         
         if
           MehrereSeiten = False
           or
             (MehrereSeiten
              and
                ZeileSchleifenwert < Ende)
         then
            Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                               str  => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));
            Sf.Graphics.Text.setPosition (text     => TextAccess,
                                          position => (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess), YPosition));
            Sf.Graphics.Text.setColor (text  => TextAccess,
                                       color => AktuelleTextFarbe);
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                               text         => TextAccess);
         
            YPosition := YPosition + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 3.00 * ZeilenAbstand;
            
         elsif
           MehrereSeiten
           and
             ZeileSchleifenwert = Ende
         then
            Sf.Graphics.ConvexShape.setPointCount (shape => PfeilAccess,
                                                   count => 7);
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 0,
                                              point => (0.00, 0.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 1,
                                              point => (40.00, 0.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 2,
                                              point => (40.00, -15.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 3,
                                              point => (70.00, 10.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 4,
                                              point => (40.00, 35.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 5,
                                              point => (40.00, 20.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 6,
                                              point => (0.00, 20.00));
            Sf.Graphics.ConvexShape.setPosition (shape    => PfeilAccess,
                                                 position => (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess), YPosition + 15.00));
            Sf.Graphics.ConvexShape.setFillColor (shape => PfeilAccess,
                                                  color => AktuelleTextFarbe);
            Sf.Graphics.RenderWindow.drawConvexShape (renderWindow => GrafikEinstellungen.Fenster,
                                                      object       => PfeilAccess);
            
         else
            null;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeSpracheSFML;
   
   

   procedure AnzeigeSpracheKonsole
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      --  LängsterText := 1;
      
      --  TextlängePrüfenSchleife:
      --  for ZeilenSchleifenwert in AktuelleSprachenArray'First .. LetzteZeileExtern loop
         
      --     if
      --      To_Wide_Wide_String (Source => AktuelleSprachen (ZeilenSchleifenwert))'Length > LängsterText
      --    then
      --       LängsterText := To_Wide_Wide_String (Source => AktuelleSprachen (ZeilenSchleifenwert))'Length;
            
      --    else
      --       null;
      --    end if;
         
      --  end loop TextlängePrüfenSchleife;
      
      -- AnzeigeSchleife:
      --  for ZeileSchleifenwert in AktuelleSprachenArray'First .. LetzteZeileExtern loop

      --     if
      --       AktuelleAuswahlExtern = ZeileSchleifenwert
      --     then
      --       RahmenTeilEinsSchleife:
      --       for TextlängeEins in 1 .. LängsterText loop
                  
      --        if
      --          TextlängeEins = 1
      --       then
      Put (Item => "╔");
      Put (Item => "═");

      --       elsif
      --        TextlängeEins = LängsterText
      --      then
      Put (Item => "═");
      Put_Line (Item => "╗");
      Put (Item => "║");
      --         Put (Item => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));

      --         LeererPlatzSchleife:
      --         for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert))'Length loop
                        
      Put (" ");
                        
      --        end loop LeererPlatzSchleife;

      Put_Line (Item => "║");
      Put (Item => "╚");

      --      else
      Put (Item => "═");
      --     end if;
               
      --  end loop RahmenTeilEinsSchleife;

      --  RahmenTeilZweiSchleife:
      --  for TextlängeZweiSchleifenwert in 1 .. LängsterText loop
               
      --    if
      --      TextlängeZweiSchleifenwert = LängsterText
      --    then
      Put (Item => "═");
      Put_Line (Item => "╝");
               
      --    else
      Put (Item => "═");
      --    end if;
            
      --  end loop RahmenTeilZweiSchleife;
         
      -- else
      --     Put_Line (Item => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));
      --  end if;
         
      --  end loop AnzeigeSchleife;
      
   end AnzeigeSpracheKonsole;

end AuswahlSpracheAnzeige;
