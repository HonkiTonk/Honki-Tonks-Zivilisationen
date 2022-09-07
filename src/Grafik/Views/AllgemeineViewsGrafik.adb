pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with TextaccessVariablen;
with Views;
with SonstigesKonstanten;

with TextberechnungenBreiteGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with EinstellungenGrafik;
with MenuestringsSetzenGrafik;
with TextberechnungenHoeheGrafik;

package body AllgemeineViewsGrafik is
      
   procedure Überschrift
     (ÜberschriftExtern : in Wide_Wide_String;
      HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum)
   is begin
      
      Viewfläche (Überschrift_Enum) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Überschrift_Enum),
                                                                                            VerhältnisExtern => (1.00, 0.10));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ÜberschriftviewAccess,
                                            GrößeExtern          => Viewfläche (Überschrift_Enum),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Überschriftbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => HintergrundExtern,
                                     AbmessungenExtern => Viewfläche (Überschrift_Enum));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ÜberschriftAccess,
                                         str  => ÜberschriftExtern);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                              ViewbreiteExtern => Viewfläche (Überschrift_Enum).x);
      Textposition.y := 2.00 * TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ÜberschriftAccess,
                                    position => Textposition);

      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ÜberschriftAccess);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                          TextbreiteExtern => 0.00);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);

      Viewfläche (Überschrift_Enum) := (Textbreite, Textposition.y);
         
   end Überschrift;
   
   
   
   procedure ÜberschriftErmitteln
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Ohne_Überschrift_Enum'Range =>
            Überschrift (ÜberschriftExtern => SonstigesKonstanten.Spielname,
                          HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum);
            
         when others =>
            Überschrift (ÜberschriftExtern => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => 1,
                                                                                             WelchesMenüExtern => WelchesMenüExtern),
                          HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum);
      end case;
            
   end ÜberschriftErmitteln;
   
   
   
   procedure Versionsnummer
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum)
   is begin
      
      Viewfläche (Versionsnummer_Enum) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Versionsnummer_Enum),
                                                                                              VerhältnisExtern => (0.05, 0.05));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.VersionsnummerviewAccess,
                                            GrößeExtern          => Viewfläche (Versionsnummer_Enum),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Versionsbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => HintergrundExtern,
                                     AbmessungenExtern => Viewfläche (Versionsnummer_Enum));
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.VersionsnummerAccess,
                                                                              ViewbreiteExtern => Viewfläche (Versionsnummer_Enum).x);
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.VersionsnummerAccess,
                                    position => Textposition);

      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.VersionsnummerAccess);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.VersionsnummerAccess,
                                                                          TextbreiteExtern => 0.00);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.VersionsnummerAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);

      Viewfläche (Versionsnummer_Enum) := (Textbreite, Textposition.y);
      
   end Versionsnummer;
   
   
   
   procedure Frage
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum;
      FrageExtern : in Wide_Wide_String)
   is begin
      
      Viewfläche (Frage_Enum) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Frage_Enum),
                                                                                     VerhältnisExtern => (0.50, 0.05));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (1),
                                            GrößeExtern          => Viewfläche (Frage_Enum),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Fragenbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => HintergrundExtern,
                                     AbmessungenExtern => Viewfläche (Frage_Enum));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ÜberschriftAccess,
                                         str  => FrageExtern);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                              ViewbreiteExtern => Viewfläche (Frage_Enum).x);
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ÜberschriftAccess,
                                    position => Textposition);

      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ÜberschriftAccess);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                          TextbreiteExtern => 0.00);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);

      Viewfläche (Frage_Enum) := (Textbreite, Textposition.y);
      
   end Frage;

end AllgemeineViewsGrafik;
