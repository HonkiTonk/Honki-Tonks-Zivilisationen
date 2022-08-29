pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with TextKonstanten;
with TextaccessVariablen;
with Views;
with SonstigesKonstanten;

with TextberechnungenBreiteSFML;
with ViewsEinstellenSFML;
with HintergrundSFML;
with GrafikEinstellungenSFML;
with AuswahlMenuesStringsSetzen;
with TextberechnungenHoeheSFML;

package body AllgemeineViewsSFML is
      
   procedure Überschrift
     (ÜberschriftExtern : in Wide_Wide_String;
      HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum)
   is begin
      
      Viewfläche (Überschrift_Enum) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Überschrift_Enum),
                                                                                            VerhältnisExtern => (1.00, 0.10));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.ÜberschriftviewAccess,
                                          GrößeExtern          => Viewfläche (Überschrift_Enum),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Überschriftbereich);
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => HintergrundExtern,
                                        AbmessungenExtern => Viewfläche (Überschrift_Enum));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ÜberschriftAccess,
                                         str  => ÜberschriftExtern);
      
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                            ViewbreiteExtern => Viewfläche (Überschrift_Enum).x);
      Textposition.y := TextKonstanten.StartpositionText.y;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ÜberschriftAccess,
                                    position => Textposition);

      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ÜberschriftAccess);
      
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                        TextbreiteExtern => 0.00);

      Viewfläche (Überschrift_Enum) := (Textbreite, Textposition.y + TextKonstanten.TexthöheZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ÜberschriftAccess).height);
         
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
            
         when others =>
            Überschrift (ÜberschriftExtern => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 1,
                                                                                                     WelchesMenüExtern => WelchesMenüExtern),
                          HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum);
      end case;
            
   end ÜberschriftErmitteln;
   
   
   
   procedure Versionsnummer
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum)
   is begin
      
      Viewfläche (Versionsnummer_Enum) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Versionsnummer_Enum),
                                                                                            VerhältnisExtern => (0.05, 0.05));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.VersionsnummerviewAccess,
                                          GrößeExtern          => Viewfläche (Versionsnummer_Enum),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Versionsbereich);
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => HintergrundExtern,
                                        AbmessungenExtern => Viewfläche (Versionsnummer_Enum));
      
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.VersionsnummerAccess,
                                                                            ViewbreiteExtern => Viewfläche (Versionsnummer_Enum).x);
      Textposition.y := TextKonstanten.StartpositionText.y;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.VersionsnummerAccess,
                                    position => Textposition);

      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.VersionsnummerAccess);
      
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.VersionsnummerAccess,
                                                                        TextbreiteExtern => 0.00);

      Viewfläche (Versionsnummer_Enum) := (Textbreite, Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.VersionsnummerAccess).height);
      
   end Versionsnummer;
   
   
   
   procedure Frage
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum;
      FrageExtern : in Wide_Wide_String)
   is begin
      
      Viewfläche (Frage_Enum) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Frage_Enum),
                                                                                   VerhältnisExtern => (0.50, 0.05));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (1),
                                          GrößeExtern          => Viewfläche (Frage_Enum),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Fragenbereich);
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => HintergrundExtern,
                                        AbmessungenExtern => Viewfläche (Frage_Enum));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ÜberschriftAccess,
                                         str  => FrageExtern);
      
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                            ViewbreiteExtern => Viewfläche (Frage_Enum).x);
      Textposition.y := TextKonstanten.StartpositionText.y;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ÜberschriftAccess,
                                    position => Textposition);

      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ÜberschriftAccess);
      
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                        TextbreiteExtern => 0.00);

      Viewfläche (Frage_Enum) := (Textbreite, Textposition.y + TextKonstanten.TexthöheZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ÜberschriftAccess).height);
      
   end Frage;

end AllgemeineViewsSFML;
