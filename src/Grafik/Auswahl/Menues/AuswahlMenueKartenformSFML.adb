pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with KartenDatentypen; use KartenDatentypen;
with SystemKonstanten;
with TextaccessVariablen;
with TextKonstanten;
with InteraktionAuswahl;
with Menuetexte;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with AuswahlMenuesStringsSetzen;
with KartengeneratorVariablen;
with TextberechnungenHoeheSFML;
with TexteinstellungenSFML;

package body AuswahlMenueKartenformSFML is

   function AuswahlMenüKartenform
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheSFML.Zeilenabstand;
      Textbreite := TextKonstanten.LeerTextbreite;
      
      PositionenSchleife:
      for PositionSchleifenwert in Textarrayanpassung .. SystemKonstanten.EndeAbzugGrafik (WelchesMenüExtern) loop
      
         FarbenFestlegen (AktuellerTextExtern   => PositionSchleifenwert,
                          AktuelleAuswahlExtern => AktuelleAuswahlExtern + 1);

         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                            str  => TextEinlesen (SchleifenwertExtern => PositionSchleifenwert));
         
         Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                               ViewbreiteExtern => ViewflächeExtern.x);
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                       position => Textposition);

         Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                           TextbreiteExtern => Textbreite);
         
         InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert - 1)
           := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert));
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert));
         
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y);
            
   end AuswahlMenüKartenform;
   
   
   
   procedure FarbenFestlegen
     (AktuellerTextExtern : in Positive;
      AktuelleAuswahlExtern : in Natural)
   is begin
      
      if
        AktuellerTextExtern = AktuelleAuswahlExtern
      then
         Farbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
         
      else
         Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
      end if;
   
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsSFMLAccess (MenueDatentypen.Kartenform_Menü_Enum, AktuellerTextExtern),
                                 color => Farbe);
      
   end FarbenFestlegen;
   
   
   
   function TextEinlesen
     (SchleifenwertExtern : in Positive)
      return Wide_Wide_String
   is begin
      
      case
        SchleifenwertExtern
      is
         when 2 =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseOben = KartenDatentypen.Karte_E_Kein_Übergang_Enum
            then
               WelcherZusatztext := 11;
               
            else
               WelcherZusatztext := 12;
            end if;
            
         when 3 =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseUnten = KartenDatentypen.Karte_E_Kein_Übergang_Enum
            then
               WelcherZusatztext := 11;
               
            else
               WelcherZusatztext := 12;
            end if;

            Zusatztext := " - " & Menuetexte.Kartenform (WelcherZusatztext);

         when 4 =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
            then
               WelcherZusatztext := 11;

            elsif
              KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Übergang_Enum
            then
               WelcherZusatztext := 12;

            elsif
              KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := 13;

            else
               WelcherZusatztext := 14;
            end if;

         when 5 =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
            then
               WelcherZusatztext := 11;

            elsif
              KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Übergang_Enum
            then
               WelcherZusatztext := 12;

            elsif
              KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := 13;

            else
               WelcherZusatztext := 14;
            end if;

         when 6 =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
            then
               WelcherZusatztext := 11;

            elsif
              KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Übergang_Enum
            then
               WelcherZusatztext := 12;

            elsif
              KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := 13;

            else
               WelcherZusatztext := 14;
            end if;

         when 7 =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
            then
               WelcherZusatztext := 11;

            elsif
              KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Übergang_Enum
            then
               WelcherZusatztext := 12;

            elsif
              KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := 13;

            else
               WelcherZusatztext := 14;
            end if;
            
         when others =>
            return AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => SchleifenwertExtern,
                                                                        WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum);
      end case;

      Zusatztext := " - " & Menuetexte.Kartenform (WelcherZusatztext);
      
      return AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => SchleifenwertExtern,
                                                                  WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum)
        & To_Wide_Wide_String (Source => Zusatztext);
            
   end TextEinlesen;

end AuswahlMenueKartenformSFML;
