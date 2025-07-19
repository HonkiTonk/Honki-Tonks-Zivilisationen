with Sf;
with Sf.Graphics.Text;

with TextKonstantenHTSEB;

with KartenartDatentypen;
with MenueKonstanten;
with TextaccessVariablen;
with InteraktionAuswahl;
with Menuetexte;
with GrafikKonstanten;

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
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
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
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
         
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
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneOben = KartenartDatentypen.Ebene_Übergangslos_Enum
            then
               WelcherZusatztext := KeinÜbergang;
               
            else
               WelcherZusatztext := Übergang;
            end if;
            
         when EbeneUnten =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneUnten = KartenartDatentypen.Ebene_Übergangslos_Enum
            then
               WelcherZusatztext := KeinÜbergang;
               
            else
               WelcherZusatztext := Übergang;
            end if;

            Zusatztext := TextKonstantenHTSEB.Trennstrich & Menuetexte.Kartenform (WelcherZusatztext);

         when Norden =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteNorden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
            then
               WelcherZusatztext := KeinÜbergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteNorden = KartenartDatentypen.Senkrechte_Übergang_Enum
            then
               WelcherZusatztext := Übergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteNorden = KartenartDatentypen.Senkrechte_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := RückwärtsVerschobenerÜbergang;

            else
               WelcherZusatztext := VerschobenerÜbergang;
            end if;

         when Süden =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteSüden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
            then
               WelcherZusatztext := KeinÜbergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteSüden = KartenartDatentypen.Senkrechte_Übergang_Enum
            then
               WelcherZusatztext := Übergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteSüden = KartenartDatentypen.Senkrechte_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := RückwärtsVerschobenerÜbergang;

            else
               WelcherZusatztext := VerschobenerÜbergang;
            end if;

         when Westen =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteWesten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
            then
               WelcherZusatztext := KeinÜbergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteWesten = KartenartDatentypen.Waagerechte_Übergang_Enum
            then
               WelcherZusatztext := Übergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteWesten = KartenartDatentypen.Waagerechte_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := RückwärtsVerschobenerÜbergang;

            else
               WelcherZusatztext := VerschobenerÜbergang;
            end if;

         when Osten =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteOsten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
            then
               WelcherZusatztext := KeinÜbergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteOsten = KartenartDatentypen.Waagerechte_Übergang_Enum
            then
               WelcherZusatztext := Übergang;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteOsten = KartenartDatentypen.Waagerechte_Rückwärts_Verschobener_Übergang_Enum
            then
               WelcherZusatztext := RückwärtsVerschobenerÜbergang;

            else
               WelcherZusatztext := VerschobenerÜbergang;
            end if;
            
         when others =>
            return MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => SchleifenwertExtern,
                                                                WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum);
      end case;

      Zusatztext := TextKonstantenHTSEB.Trennstrich & Menuetexte.Kartenform (WelcherZusatztext);
      
      return MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => SchleifenwertExtern,
                                                          WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum)
        & To_Wide_Wide_String (Source => Zusatztext);
            
   end TextEinlesen;

end KartenformmenueGrafik;
