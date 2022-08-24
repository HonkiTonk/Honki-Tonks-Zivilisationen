pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with KartenDatentypen;
with SpielVariablen;
with SpielDatentypen;
with TextaccessVariablen;
with SystemKonstanten;
with InteraktionAuswahl;
with Views;
with GrafikRecordKonstanten;
with GrafikDatentypen;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with AuswahlMenuesStringsSetzen;
with AuswahlMenuesZusatztextSFML;
with KartengeneratorVariablen;
with TextberechnungenHoeheSFML;
with TexteinstellungenSFML;
with ViewsEinstellenSFML;
with HintergrundSFML;

package body AuswahlMenuesEinfachSFML is

   procedure AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Integer)
   is begin
      
      Viewfläche := ViewsEinstellenSFML.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.MenüviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.MenüEinfachbereich);
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche);
                  
      Viewfläche := Textbearbeitung (WelchesMenüExtern     => WelchesMenüExtern,
                                      ViewflächeExtern      => Viewfläche,
                                      AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      Viewfläche.y := Viewfläche.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
                              
   end AuswahlMenüsEinfach;
   
   
   
   -- TextbereichEnde später mal in TextendeExtern oder sowas umbenennen. äöü
   function Textbearbeitung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Integer)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition := TextpositionFestlegen (WelchesMenüExtern     => WelchesMenüExtern,
                                             ViewflächeExtern      => ViewflächeExtern,
                                             AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Zusatztext_Einfach_Enum'Range =>
            return AuswahlMenuesZusatztextSFML.MenüsZusatztextAufteilung (WelchesMenüExtern          => WelchesMenüExtern,
                                                                           AktuelleAuswahlExtern      => AktuelleAuswahlExtern,
                                                                           ViewflächeExtern           => ViewflächeExtern,
                                                                           TextpositionExtern         => Textposition,
                                                                           AnzeigebereichbreiteExtern => 1.00);
            
         when others =>
            return Textposition;
      end case;
      
   end Textbearbeitung;
   
   
   
   -- Hier noch TextbereichExtern einbauen und TextbereichExtern mal in Ende/EndeExtern umbenennen. äöü
   procedure FarbeFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural;
      AktuellerTextExtern : in Positive)
   is begin
            
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Kartenart_Menü_Enum =>
            AktuelleEinstellung := Textarrayanpassung + KartenDatentypen.Kartenart_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenart);
            
         when MenueDatentypen.Kartentemperatur_Menü_Enum =>
            AktuelleEinstellung := Textarrayanpassung + KartenDatentypen.Kartentemperatur_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartentemperatur);
            
         when MenueDatentypen.Kartenressourcen_Menü_Enum =>
            AktuelleEinstellung := Textarrayanpassung + KartenDatentypen.Kartenressourcen_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenressourcen);
            
         when MenueDatentypen.Schwierigkeitsgrad_Menü_Enum =>
            AktuelleEinstellung := Textarrayanpassung + SpielDatentypen.Schwierigkeitsgrad_Enum'Pos (SpielVariablen.Allgemeines.Schwierigkeitsgrad);
            
         when others =>
            AktuelleEinstellung := 0;
      end case;
      
      if
        AktuellerTextExtern = AktuelleAuswahlExtern
      then
         Farbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
         
      elsif
        AktuelleEinstellung = AktuellerTextExtern
      then
         Farbe := TexteinstellungenSFML.Schriftfarben.FarbeMenschText;
      
      else
         Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
      end if;
   
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, AktuellerTextExtern),
                                 color => Farbe);
      
   end FarbeFestlegen;
   
   
   
   function TextpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Integer)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Rechenwert.y := TextberechnungenHoeheSFML.Zeilenabstand;
      Textbreite := 0.00;

      PositionenSchleife:
      for PositionSchleifenwert in Textarrayanpassung .. SystemKonstanten.EndeAbzugGrafik (WelchesMenüExtern) loop
      
         FarbeFestlegen (WelchesMenüExtern     => WelchesMenüExtern,
                         AktuelleAuswahlExtern => AktuelleAuswahlExtern + 1,
                         AktuellerTextExtern   => PositionSchleifenwert);

         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                            str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => PositionSchleifenwert,
                                                                                                         WelchesMenüExtern => WelchesMenüExtern));
         
         Rechenwert.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                             ViewbreiteExtern => ViewflächeExtern.x);
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                       position => Rechenwert);

         Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                           TextbreiteExtern => Textbreite);
         
         InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert - 1)
           := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert));
         
         Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.MenüsSFMLAccess (WelchesMenüExtern, PositionSchleifenwert));
         
      end loop PositionenSchleife;

      return (Textbreite, Rechenwert.y);

   end TextpositionFestlegen;

end AuswahlMenuesEinfachSFML;
