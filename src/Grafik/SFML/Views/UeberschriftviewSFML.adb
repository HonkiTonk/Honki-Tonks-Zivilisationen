pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with TextKonstanten;
with TextaccessVariablen;
with ViewsSFML;
with SonstigesKonstanten;
with GrafikKonstanten;

with TextberechnungenBreiteSFML;
with ViewsEinstellenSFML;
with HintergrundSFML;
with GrafikEinstellungenSFML;
with AuswahlMenuesStringsSetzen;
with TextberechnungenHoeheSFML;

package body UeberschriftviewSFML is
      
   procedure Überschrift
     (ÜberschriftExtern : in Wide_Wide_String;
      HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum)
   is begin
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ÜberschriftviewAccess,
                                          GrößeExtern          => Viewfläche (Überschrift_Enum),
                                          AnzeigebereichExtern => GrafikKonstanten.Überschriftbereich);
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => HintergrundExtern,
                                        AbmessungenExtern => Viewfläche (Überschrift_Enum));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ÜberschriftAccess,
                                         str  => ÜberschriftExtern);
      
      TextPosition.x := Viewfläche (Überschrift_Enum).x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess);
      TextPosition.y := TextKonstanten.StartpositionText.y;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ÜberschriftAccess,
                                    position => TextPosition);

      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ÜberschriftAccess);

      Viewfläche (Überschrift_Enum) := (TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ÜberschriftAccess).width,
                                          TextPosition.y + TextKonstanten.TexthöheZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ÜberschriftAccess).height);
         
   end Überschrift;
   
   
   
   procedure ÜberschriftErmitteln
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Ohne_Überschrift_Enum'Range =>
            Überschrift (ÜberschriftExtern => SonstigesKonstanten.Spielname,
                          HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum);
            
         when MenueDatentypen.Menü_Mit_Überschrift_Enum'Range | MenueDatentypen.Menü_Zusatztext_Einfach_Enum'Range =>
            Überschrift (ÜberschriftExtern => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 1,
                                                                                                     WelchesMenüExtern => WelchesMenüExtern),
                          HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum);
            
            -- Das hier später entsprechend anpassen. äöü
         when others =>
            return;
      end case;
            
   end ÜberschriftErmitteln;
   
   
   
   procedure Versionsnummer
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum)
   is begin
      
      Viewfläche (Versionsnummer_Enum) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Versionsnummer_Enum),
                                                                                            VerhältnisExtern => (0.05, 0.05));
      Viewfläche (Versionsnummer_Enum) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Versionsnummer_Enum),
                                                                                            VerhältnisExtern => (0.05, 0.05));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ÜberschriftviewAccess,
                                          GrößeExtern          => Viewfläche (Versionsnummer_Enum),
                                          AnzeigebereichExtern => GrafikKonstanten.Versionsbereich);
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => HintergrundExtern,
                                        AbmessungenExtern => Viewfläche (Versionsnummer_Enum));
      
      TextPosition.x := Viewfläche (Versionsnummer_Enum).x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.VersionsnummerAccess);
      TextPosition.y := TextKonstanten.StartpositionText.y;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.VersionsnummerAccess,
                                    position => TextPosition);

      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.VersionsnummerAccess);

      Viewfläche (Versionsnummer_Enum) := (TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.VersionsnummerAccess).width,
                                            TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.VersionsnummerAccess).height);
      
   end Versionsnummer;

end UeberschriftviewSFML;
