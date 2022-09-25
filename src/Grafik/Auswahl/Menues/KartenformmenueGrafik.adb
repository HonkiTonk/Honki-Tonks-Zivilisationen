pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with KartenDatentypen; use KartenDatentypen;
with SystemKonstanten;
with TextaccessVariablen;
with InteraktionAuswahl;
with Menuetexte;

with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with MenuestringsSetzenGrafik;
with KartengeneratorVariablenLogik;
with TextberechnungenHoeheGrafik;
with TextfarbeGrafik;

package body KartenformmenueGrafik is

   function Kartenformmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := 0.00;
      
      PositionenSchleife:
      for PositionSchleifenwert in SystemKonstanten.StandardArrayanpassung .. SystemKonstanten.EndeAbzugGrafik (WelchesMenüExtern) loop
      
         TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => PositionSchleifenwert,
                                                AuswahlExtern    => AktuelleAuswahlExtern + 1,
                                                TextaccessExtern => TextaccessVariablen.MenüsSFMLAccess (MenueDatentypen.Kartenform_Menü_Enum, PositionSchleifenwert));

         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                            str  => TextEinlesen (SchleifenwertExtern => PositionSchleifenwert));
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                                 ViewbreiteExtern => ViewflächeExtern.x);
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                       position => Textposition);

         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                           TextbreiteExtern => Textbreite);
         
         InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert - 1)
           := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert));
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert));
         
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y);
            
   end Kartenformmenü;
   
   
   
   function TextEinlesen
     (SchleifenwertExtern : in Positive)
      return Wide_Wide_String
   is begin
      
      case
        SchleifenwertExtern
      is
         when 2 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseOben = KartenDatentypen.Karte_E_Kein_Übergang_Enum
            then
               WelcherZusatztext := 11;
               
            else
               WelcherZusatztext := 12;
            end if;
            
         when 3 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseUnten = KartenDatentypen.Karte_E_Kein_Übergang_Enum
            then
               WelcherZusatztext := 11;
               
            else
               WelcherZusatztext := 12;
            end if;

            Zusatztext := " - " & Menuetexte.Kartenform (WelcherZusatztext);

         when 4 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
            then
               WelcherZusatztext := 11;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Übergang_Enum
            then
               WelcherZusatztext := 12;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := 13;

            else
               WelcherZusatztext := 14;
            end if;

         when 5 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
            then
               WelcherZusatztext := 11;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Übergang_Enum
            then
               WelcherZusatztext := 12;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := 13;

            else
               WelcherZusatztext := 14;
            end if;

         when 6 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
            then
               WelcherZusatztext := 11;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Übergang_Enum
            then
               WelcherZusatztext := 12;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := 13;

            else
               WelcherZusatztext := 14;
            end if;

         when 7 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
            then
               WelcherZusatztext := 11;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Übergang_Enum
            then
               WelcherZusatztext := 12;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := 13;

            else
               WelcherZusatztext := 14;
            end if;
            
         when others =>
            return MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => SchleifenwertExtern,
                                                                WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum);
      end case;

      Zusatztext := " - " & Menuetexte.Kartenform (WelcherZusatztext);
      
      return MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => SchleifenwertExtern,
                                                          WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum)
        & To_Wide_Wide_String (Source => Zusatztext);
            
   end TextEinlesen;

end KartenformmenueGrafik;
