with Sf.Graphics.Text;

with TextaccessVariablen;
with Views;
with SonstigesKonstanten;
with ViewKonstanten;
with GrafikKonstanten;

with TextberechnungenBreiteGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with MenuestringsSetzenGrafik;
with TextberechnungenHoeheGrafik;
with TextaccessverwaltungssystemGrafik;

package body AllgemeineViewsGrafik is
      
   procedure Überschrift
     (ÜberschriftExtern : in Wide_Wide_String;
      HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum;
      SpielenamenExtern : in Boolean)
   is begin
      
      case
        SpielenamenExtern
      is
         when True =>
            null;
            
         when False =>
            Viewfläche (Überschrift_Enum) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Überschrift_Enum),
                                                                                                  VerhältnisExtern => (GrafikRecordKonstanten.Überschriftbereich.width, GrafikRecordKonstanten.Überschriftbereich.height));
      end case;
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ÜberschriftviewAccess,
                                            GrößeExtern          => Viewfläche (Überschrift_Enum),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Überschriftbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => HintergrundExtern,
                                     AbmessungenExtern => Viewfläche (Überschrift_Enum));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ÜberschriftAccess,
                                         str  => ÜberschriftExtern);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                              ViewbreiteExtern => Viewfläche (Überschrift_Enum).x);
      Textposition.y := GrafikKonstanten.Verdoppelung * TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                          PositionExtern   => Textposition);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                          TextbreiteExtern => GrafikKonstanten.Nullwert);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel + TextberechnungenHoeheGrafik.ZeilenabstandVariabel);

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
                          HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                          SpielenamenExtern => True);
            
         when others =>
            Überschrift (ÜberschriftExtern => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => 1,
                                                                                          WelchesMenüExtern => WelchesMenüExtern),
                          HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                          SpielenamenExtern => False);
      end case;
            
   end ÜberschriftErmitteln;
   
   
   
   procedure Versionsnummer
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum)
   is begin
      
      Viewfläche (Versionsnummer_Enum) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Versionsnummer_Enum),
                                                                                              VerhältnisExtern => (GrafikRecordKonstanten.Versionsbereich.width, GrafikRecordKonstanten.Versionsbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.VersionsnummerviewAccess,
                                            GrößeExtern          => Viewfläche (Versionsnummer_Enum),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Versionsbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => HintergrundExtern,
                                     AbmessungenExtern => Viewfläche (Versionsnummer_Enum));
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.VersionsnummerAccess,
                                                                              ViewbreiteExtern => Viewfläche (Versionsnummer_Enum).x);
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.VersionsnummerAccess,
                                                          PositionExtern   => Textposition);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.VersionsnummerAccess,
                                                                          TextbreiteExtern => GrafikKonstanten.Nullwert);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.VersionsnummerAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);

      Viewfläche (Versionsnummer_Enum) := (Textbreite, Textposition.y);
      
   end Versionsnummer;
   
   
   
   -- Das hier vielleicht nach EingabeanzeigeGrafik schieben? Wird aktuell ja nur dort benötigt. äöü
   procedure Frage
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum;
      FrageExtern : in Wide_Wide_String)
   is begin
      
      Viewfläche (Frage_Enum) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Frage_Enum),
                                                                                     VerhältnisExtern => (GrafikRecordKonstanten.Fragenbereich.width, GrafikRecordKonstanten.Fragenbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (ViewKonstanten.Frage),
                                            GrößeExtern          => Viewfläche (Frage_Enum),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Fragenbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => HintergrundExtern,
                                     AbmessungenExtern => Viewfläche (Frage_Enum));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ÜberschriftAccess,
                                         str  => FrageExtern);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                              ViewbreiteExtern => Viewfläche (Frage_Enum).x);
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                          PositionExtern   => Textposition);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                          TextbreiteExtern => GrafikKonstanten.Nullwert);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);

      Viewfläche (Frage_Enum) := (Textbreite, Textposition.y);
      
   end Frage;

end AllgemeineViewsGrafik;
