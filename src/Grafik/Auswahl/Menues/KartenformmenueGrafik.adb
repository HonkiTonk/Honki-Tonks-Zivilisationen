with Sf;
with Sf.Graphics.Text;

with KartenartDatentypen;
with MenueKonstanten;
with TextaccessVariablen;
with InteraktionAuswahl;
with Menuetexte;
with GrafikKonstanten;
with TextKonstanten;

with TextberechnungenBreiteGrafik;
with MenuestringsSetzenGrafik;
with KartengeneratorVariablenLogik;
with TextberechnungenHoeheGrafik;
with TextfarbeGrafik;
with TextaccessverwaltungssystemEinfachGrafik;

package body KartenformmenueGrafik is

   function Kartenformmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := GrafikKonstanten.Nullwert;
      
      PositionenSchleife:
      for PositionSchleifenwert in MenueKonstanten.StandardArrayanpassung .. MenueKonstanten.EndeAbzugGrafik (WelchesMenüExtern) loop
      
         TextaccessverwaltungssystemEinfachGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.MenüsAccess (MenueDatentypen.Kartenform_Menü_Enum, PositionSchleifenwert),
                                                      TextExtern       => TextEinlesen (SchleifenwertExtern => PositionSchleifenwert),
                                                      FarbeExtern      => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => PositionSchleifenwert,
                                                                                                                 AuswahlExtern    => AktuelleAuswahlExtern + MenueKonstanten.SchleifenanpassungGrafikLogik));
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                                 ViewbreiteExtern => ViewflächeExtern.x);
         
         TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                             PositionExtern   => Textposition);

         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert - MenueKonstanten.SchleifenanpassungGrafikLogik)
           := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert));
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y);
            
   end Kartenformmenü;
   
   
   
   function TextEinlesen
     (SchleifenwertExtern : in Positive)
      return Wide_Wide_String
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      case
        SchleifenwertExtern
      is
         when EbeneOben =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseOben = KartenartDatentypen.Karte_E_Kein_Übergang_Enum
            then
               WelcherZusatztext := KeinÜbergang;
               
            else
               WelcherZusatztext := Übergang;
            end if;
            
         when EbeneUnten =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseUnten = KartenartDatentypen.Karte_E_Kein_Übergang_Enum
            then
               WelcherZusatztext := KeinÜbergang;
               
            else
               WelcherZusatztext := Übergang;
            end if;

            Zusatztext := TextKonstanten.Trennstrich & Menuetexte.Kartenform (WelcherZusatztext);

         when Norden =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
            then
               WelcherZusatztext := KeinÜbergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Übergang_Enum
            then
               WelcherZusatztext := Übergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := RückwärtsVerschobenerÜbergang;

            else
               WelcherZusatztext := VerschobenerÜbergang;
            end if;

         when Süden =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
            then
               WelcherZusatztext := KeinÜbergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Übergang_Enum
            then
               WelcherZusatztext := Übergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := RückwärtsVerschobenerÜbergang;

            else
               WelcherZusatztext := VerschobenerÜbergang;
            end if;

         when Westen =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
            then
               WelcherZusatztext := KeinÜbergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Übergang_Enum
            then
               WelcherZusatztext := Übergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := RückwärtsVerschobenerÜbergang;

            else
               WelcherZusatztext := VerschobenerÜbergang;
            end if;

         when Osten =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
            then
               WelcherZusatztext := KeinÜbergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Übergang_Enum
            then
               WelcherZusatztext := Übergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := RückwärtsVerschobenerÜbergang;

            else
               WelcherZusatztext := VerschobenerÜbergang;
            end if;
            
         when others =>
            return MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => SchleifenwertExtern,
                                                                WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum);
      end case;

      Zusatztext := TextKonstanten.Trennstrich & Menuetexte.Kartenform (WelcherZusatztext);
      
      return MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => SchleifenwertExtern,
                                                          WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum)
        & To_Wide_Wide_String (Source => Zusatztext);
            
   end TextEinlesen;

end KartenformmenueGrafik;
