pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with RassenDatentypen; use RassenDatentypen;
with Views;
with GrafikDatentypen;
with SpielVariablen;
with TextaccessVariablen;
with SystemKonstanten;
with InteraktionAuswahl;
with RassenKonstanten;

with ViewsEinstellenSFML;
with HintergrundSFML;
with TexteinstellungenSFML;
with TextberechnungenBreiteSFML;
with TextberechnungenHoeheSFML;
with GrafikEinstellungenSFML;
with AuswahlMenuesStringsSetzen;
with AuswahlMenuesZusatztextSFML;
with AuswahlMenueKartenformSFML;

package body AuswahlMenueDoppeltSFML is

   procedure AuswahlMenüDoppelt
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      AktuelleAuswahlExtern : in Natural)
   is begin
      
      Viewfläche (Auswahlbereich) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Auswahlbereich),
                                                                                     VerhältnisExtern => (0.25, 1.00));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.MenüviewAccess,
                                          GrößeExtern          => Viewfläche (Auswahlbereich),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.MenüDoppelbereich (Auswahlbereich));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (Auswahlbereich));
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Rassen_Menü_Enum =>
            Viewfläche (Auswahlbereich) := TextpositionFestlegen (WelchesMenüExtern    => WelchesMenüExtern,
                                                                   ViewflächeExtern     => Viewfläche (Auswahlbereich),
                                                                   AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when MenueDatentypen.Kartenform_Menü_Enum =>
            Viewfläche (Auswahlbereich) := AuswahlMenueKartenformSFML.AuswahlMenüKartenform (WelchesMenüExtern     => WelchesMenüExtern,
                                                                                             ViewflächeExtern      => Viewfläche (Auswahlbereich),
                                                                                             AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end case;

      Viewfläche (Auswahlbereich).y := Viewfläche (Auswahlbereich).y + TextberechnungenHoeheSFML.KleinerZeilenabstand;


      
      Viewfläche (Zusatzbereich) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Zusatzbereich),
                                                                                    VerhältnisExtern => (1.00, 1.00));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.ZusatztextviewAccess,
                                          GrößeExtern          => Viewfläche (Zusatzbereich),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.MenüDoppelbereich (Zusatzbereich));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (Zusatzbereich));
      
      Viewfläche (Zusatzbereich) := AuswahlMenuesZusatztextSFML.MenüsZusatztextAufteilung (WelchesMenüExtern          => WelchesMenüExtern,
                                                                                           AktuelleAuswahlExtern      => AktuelleAuswahlExtern,
                                                                                           ViewflächeExtern           => Viewfläche (Zusatzbereich),
                                                                                           TextpositionExtern         => TextKonstanten.StartpositionText,
                                                                                             AnzeigebereichbreiteExtern => GrafikRecordKonstanten.MenüDoppelbereich (Zusatzbereich).width);
      
      Viewfläche (Zusatzbereich).y := Viewfläche (Zusatzbereich).y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end AuswahlMenüDoppelt;
   
   
   
   function TextpositionFestlegen
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
                          AktuelleAuswahlExtern => AktuelleAuswahlExtern + 1,
                          WelchesMenüExtern     => WelchesMenüExtern);

         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                            str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => PositionSchleifenwert,
                                                                                                         WelchesMenüExtern => WelchesMenüExtern));
                  
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

   end TextpositionFestlegen;
   
   
   
   procedure FarbenFestlegen
     (AktuellerTextExtern : in Positive;
      AktuelleAuswahlExtern : in Natural;
      WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum)
   is begin
      
      if
        AktuelleAuswahlExtern = AktuellerTextExtern
      then
         Farbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
         
      elsif
        AktuellerTextExtern - 1 in RassenKonstanten.Rassenanfang .. RassenKonstanten.Rassenende
      then
         case
           SpielVariablen.RassenImSpiel (RassenDatentypen.Rassen_Verwendet_Enum'Val (AktuellerTextExtern - 1))
         is
            when RassenDatentypen.Mensch_Spieler_Enum =>
               Farbe := TexteinstellungenSFML.Schriftfarben.FarbeMenschText;
               
            when RassenDatentypen.KI_Spieler_Enum =>
               Farbe := TexteinstellungenSFML.Schriftfarben.FarbeKIText;
               
            when others =>
               Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
         end case;
               
      else
         Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
      end if;
   
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, AktuellerTextExtern),
                                 color => Farbe);
      
   end FarbenFestlegen;

end AuswahlMenueDoppeltSFML;
