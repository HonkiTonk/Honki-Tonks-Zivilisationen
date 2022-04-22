pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf; use Sf;
with Sf.Graphics.RenderWindow;

with SonstigesKonstanten;

with EingeleseneTexturenSFML;
with TexturenSetzenSkalierenSFML;
with GrafikEinstellungenSFML;
with AllgemeineTextBerechnungenSFML;
with InteraktionAuswahl;
with AuswahlMenuesStringsSetzen;
with Karten;

package body AuswahlMenuesKomplexSFML is

   procedure AuswahlMenüsKomplex
     (WelchesMenüExtern : in MenueDatentypen.Menü_Komplex_Enum)
   is begin
      
      MenüHintergrund (WelchesMenüExtern => WelchesMenüExtern);
      
      AktuelleAuswahlRückgabewert := Textbearbeitung;
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess (Überschrift));
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess (TextAccess'Last));
      
      PositionenSchleife:
      for PositionSchleifenwert in TextAccessArray'First + Überschrift .. 6 loop
               
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextAccess (PositionSchleifenwert));
         
         case
           PositionSchleifenwert
         is
            when 2 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextAccess (PositionSchleifenwert + WelcheForm (Karten.Kartenparameter.Kartenform.EAchseEinstellung)));
               
            when 3 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextAccess (PositionSchleifenwert + WelcheForm (Karten.Kartenparameter.Kartenform.YAchseEinstellung)));
               
            when 4 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextAccess (PositionSchleifenwert + WelcheForm (Karten.Kartenparameter.Kartenform.XAchseEinstellung)));
            when others =>
               null;
         end case;
         
      end loop PositionenSchleife;
      
   end AuswahlMenüsKomplex;
   
   
   
   ------------------------- Später auslagern.
   ------------------------- Ein SpriteAccess für jedes Menübild?
   procedure MenüHintergrund
     (WelchesMenüExtern : in MenueDatentypen.Menü_Komplex_Enum)
   is begin
      
      if
        EingeleseneTexturenSFML.MenüHintergrundAccess (WelchesMenüExtern) /= null
      then
         Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccess,
                                         position => (0.00, 0.00));
         Sf.Graphics.Sprite.scale (sprite  => SpriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenGesamtesBild (SpriteAccessExtern  => SpriteAccess,
                                                                                                               TextureAccessExtern => EingeleseneTexturenSFML.MenüHintergrundAccess (WelchesMenüExtern)));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => SpriteAccess);
         
      else
         -- Hier wird kein einfarbiger Hintergrund wie bei den Kartenfeldern benötigt, da es ja immer auf schwarz gesetzt wird.
         null;
      end if;
      
   end MenüHintergrund;
   
   
   
   function Textbearbeitung
     return Natural
   is begin
      
      case
        SchriftartFestgelegt
      is
         when False =>
            SchriftartFestgelegt := SchriftartFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftfarbeFestgelegt
      is
         when False =>
            SchriftfarbeFestgelegt := SchriftfarbenFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftgrößeFestgelegt
      is
         when False =>
            SchriftgrößeFestgelegt := SchriftgrößeFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        TextEingelesen
      is
         when False =>
            TextEingelesen := TextEinlesen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftpositionFestgelegt
      is
         when False =>
            SchriftpositionFestgelegt := SchriftpositionFestlegen;
            
         when True =>
            null;
      end case;
      
      return 0;
      
   end Textbearbeitung;
   
   
   
   function SchriftartFestlegen
     return Boolean
   is begin
      
      FontSchleife:
      for FontSchleifenwert in TextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextAccess (FontSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop FontSchleife;
            
      return True;
      
   end SchriftartFestlegen;



   function SchriftfarbenFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextAccess (Überschrift),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in TextAccessArray'First + Überschrift .. TextAccessArray'Last - Versionsnummer loop
         
         Sf.Graphics.Text.setColor (text  => TextAccess (SchriftfarbeSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop SchriftfarbeSchleife;
      
      Sf.Graphics.Text.setColor (text  => TextAccess (TextAccessArray'Last),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeSonstigerText);
      
      return True;

   end SchriftfarbenFestlegen;
   
   
   
   function SchriftgrößeFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess (Überschrift),
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      
      SchriftgrößeSchleife:
      for SchriftgrößeSchleifenwert in TextAccessArray'First + Überschrift .. TextAccessArray'Last - Versionsnummer loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextAccess (SchriftgrößeSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop SchriftgrößeSchleife;
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess (TextAccessArray'Last),
                                         size => Sf.sfUint32 (0.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      
      return True;
      
   end SchriftgrößeFestlegen;
   
   
   
   function TextEinlesen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (Überschrift),
                                         str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => Überschrift,
                                                                                                      WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
      
      TextSchleife:
      for TextSchleifenwert in TextAccessArray'First + Überschrift .. TextAccessArray'Last - Versionsnummer loop
                  
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (TextSchleifenwert),
                                            str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => TextSchleifenwert,
                                                                                                         WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
         
      end loop TextSchleife;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (TextAccessArray'Last),
                                         str  => "Version: " & SonstigesKonstanten.Versionsnummer);
      
      return True;
      
   end TextEinlesen;
   
   
   
   function SchriftpositionFestlegen
     return Boolean
   is begin
      
      ZeilenAbstand := 0.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
      Rechenwert.y := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y / 100);
      
      if
        Rechenwert.y < 20.00
      then
         Rechenwert.y := 20.00;
         
      else
         null;
      end if;
      
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (Überschrift));
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (Überschrift),
                                    position => Rechenwert);
      
      Rechenwert.y := Rechenwert.y + 3.00 * Sf.Graphics.Text.getLocalBounds (text => TextAccess (Überschrift)).height + ZeilenAbstand;
      
      PositionenSchleife:
      for PositionSchleifenwert in TextAccessArray'First + Überschrift .. 4 loop
         
         case
           PositionSchleifenwert
         is
            when 2 =>
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => False);
                           
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert),
                                             position => Rechenwert);
               
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => True);
               
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert + 5),
                                             position => Rechenwert);
               
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert + 6),
                                             position => Rechenwert);
         
               InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, PositionSchleifenwert - Überschrift) := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (PositionSchleifenwert + 5));
               
            when 3 =>
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => False);
                           
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert),
                                             position => Rechenwert);
               
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => True);
               
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert + 6),
                                             position => Rechenwert);
               
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert + 7),
                                             position => Rechenwert);
               
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert + 8),
                                             position => Rechenwert);
               
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert + 9),
                                             position => Rechenwert);
         
               InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, PositionSchleifenwert - Überschrift) := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (PositionSchleifenwert + 6));
               
            when 4 =>
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => False);
                           
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert),
                                             position => Rechenwert);
               
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => True);
               
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert + 9),
                                             position => Rechenwert);
               
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert + 10),
                                             position => Rechenwert);
               
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert + 11),
                                             position => Rechenwert);
               
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert + 12),
                                             position => Rechenwert);
               
               InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, PositionSchleifenwert - Überschrift) := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (PositionSchleifenwert + 9));
               
            when others =>
               null;
         end case;
         
         Rechenwert.y := Rechenwert.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess (Überschrift)).height + ZeilenAbstand;
         
      end loop PositionenSchleife;
      
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (5),
                                                                                   LinksRechtsExtern => False);
                           
      Sf.Graphics.Text.setPosition (text     => TextAccess (5),
                                    position => Rechenwert);
      
      InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, 5 - Überschrift) := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (5));
               
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (6),
                                                                                   LinksRechtsExtern => True);
               
      Sf.Graphics.Text.setPosition (text     => TextAccess (6),
                                    position => Rechenwert);
      
      InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, 6 - Überschrift) := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (6));
            
      --------------------- Scheint noch nicht hoch genug zu sein.
      Rechenwert.y := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) - Sf.Graphics.Text.getLocalBounds (text => TextAccess (TextAccessArray'Last)).height
        - Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y / 100);
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (TextAccessArray'Last));
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (TextAccessArray'Last),
                                    position => Rechenwert);
      
      return True;
      
   end SchriftpositionFestlegen;

end AuswahlMenuesKomplexSFML;
