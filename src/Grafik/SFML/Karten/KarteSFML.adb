pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with KartenRecords; use KartenRecords;
with EinheitenDatentypen; use EinheitenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;
with StadtKonstanten;
with SpielVariablen;
with TextaccessVariablen;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with Kartenkoordinatenberechnungssystem;
with EinheitSuchen;
with StadtSuchen;
with KarteInformationenSFML;
with BerechnungenKarteSFML;
with Fehler;
with ObjekteZeichnenSFML;
with GrafikEinstellungenSFML;
with EingeleseneTexturenSFML;
with TexturenSetzenSkalierenSFML;
with KarteGrafikenZeichnenSFML;
with FarbgebungSFML;

package body KarteSFML is
   
   procedure KarteAnzeigen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Sichtbarkeit (RasseExtern => RasseExtern);
      
      KarteInformationenSFML.KarteInformationenSFML (RasseExtern => RasseExtern);
      
   end KarteAnzeigen;
   
   

   procedure Sichtbarkeit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
        
      SichtbereichAnfangEnde := BerechnungenKarteSFML.SichtbereichKarteBerechnen (RasseExtern => RasseExtern);
      
      YMultiplikator := 0.00;
            
      YAchseSchleife:
      for YAchseSchleifenwert in SichtbereichAnfangEnde (1) .. SichtbereichAnfangEnde (2) loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in SichtbereichAnfangEnde (3) .. SichtbereichAnfangEnde (4) loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => False);
            
            -- Die Position durchzureichen bedeutet auch gleichzeitig den aktuellen Multiplikator mit durchzureichen!
            Position.x := XMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.x;
            Position.y := YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y;
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Sichtbar (KoordinatenExtern => KartenWert,
                                   RasseExtern       => RasseExtern)
              = True
            then
               IstSichtbar (KoordinatenExtern => KartenWert,
                            RasseExtern       => RasseExtern,
                            PositionExtern    => Position);
               
            else
               -- Ist das Zeichnen von schwarzen Felder notwendig? Immerhin wird ja vorher das Fenster immer geleert und auf Schwarz gesetzt.
               -- Schwarze Felder zu zeichnen könnte fehlerhafte Größenverhältnisse überdecken, lieber lassen.
               null;
            end if;
            
            XMultiplikator := XMultiplikator + 1.00;
                          
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
      
   end Sichtbarkeit;
   
   
   
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      -- Über den Kartenfeldern kommen die Kartenressourcen.
      -- Über den Kartenressourcen kommen die Kartenverbesserungen.
      -- Über die Kartenverbesserungen kommen die Städte.
      -- Über die Städte kommen die nicht Transporteinheiten.
      -- Über den nicht Transporteinheiten kommen die Transporteinheiten.
      -- Über den Transporteinheiten kommt der Cursor.
      
      AnzeigeLandschaft (KoordinatenExtern => KoordinatenExtern,
                         PositionExtern    => PositionExtern);
            
      AnzeigeStadt (KoordinatenExtern => KoordinatenExtern,
                    PositionExtern    => PositionExtern);
            
      AnzeigeEinheit (KoordinatenExtern => KoordinatenExtern,
                      RasseExtern       => RasseExtern,
                      PositionExtern    => PositionExtern);
      
      AnzeigeFeldbesitzer (KoordinatenExtern => KoordinatenExtern,
                           PositionExtern    => PositionExtern);
            
      case
        SonstigeVariablen.Debug
      is
         when True =>
            AnzeigeCursor (KoordinatenExtern => KoordinatenExtern,
                           RasseExtern       => RasseExtern,
                           PositionExtern    => PositionExtern);
            
         when False =>
            null;
      end case;
                  
   end IstSichtbar;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldZeichnen (KoordinatenExtern => KoordinatenExtern,
                          PositionExtern    => PositionExtern);
      
      RessourceZeichnen (KoordinatenExtern => KoordinatenExtern,
                         PositionExtern    => PositionExtern);
      
      FlussZeichnen (KoordinatenExtern => KoordinatenExtern,
                     PositionExtern    => PositionExtern);
      
      WegZeichnen (KoordinatenExtern => KoordinatenExtern,
                   PositionExtern    => PositionExtern);
      
      VerbesserungZeichnen (KoordinatenExtern => KoordinatenExtern,
                            PositionExtern    => PositionExtern);
      
   end AnzeigeLandschaft;
   
   
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Kartengrund := LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern);
      
      if
        EingeleseneTexturenSFML.KartenfelderAccess (Kartengrund) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenWeltkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                      TextureAccessExtern => EingeleseneTexturenSFML.KartenfelderAccess (Kartengrund)));
         
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.KartenfelderAbmessung,
                                               PositionExtern       => PositionExtern,
                                               FarbeExtern          => FarbgebungSFML.FarbeKartenfeldErmitteln (GrundExtern => Kartengrund),
                                               RechteckAccessExtern => RechteckAccess);
      end if;
      
   end KartenfeldZeichnen;
   
   
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldFluss := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      if
        KartenfeldFluss = KartengrundDatentypen.Leer_Fluss_Enum
      then
         null;
      
      elsif
        EingeleseneTexturenSFML.KartenflussAccess (KartenfeldFluss) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenWeltkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                      TextureAccessExtern => EingeleseneTexturenSFML.KartenflussAccess (KartenfeldFluss)));
         
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.KartenfelderAbmessung.x, BerechnungenKarteSFML.KartenfelderAbmessung.y / 5.00),
                                               PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.40 * BerechnungenKarteSFML.KartenfelderAbmessung.y),
                                               FarbeExtern          => FarbgebungSFML.FarbeFlussErmitteln (FlussExtern => KartenfeldFluss),
                                               RechteckAccessExtern => RechteckAccess);
      end if;
      
   end FlussZeichnen;
   
   
   
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldRessource := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      if
        KartenfeldRessource = KartengrundDatentypen.Leer_Ressource_Enum
      then
         null;
      
      elsif
        EingeleseneTexturenSFML.KartenressourceAccess (KartenfeldRessource) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  =>
                                                     TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenWeltkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                   TextureAccessExtern => EingeleseneTexturenSFML.KartenressourceAccess (KartenfeldRessource)));
         
      else
         ObjekteZeichnenSFML.KreisZeichnen (RadiusExtern      => BerechnungenKarteSFML.KartenfelderAbmessung.x / 3.00,
                                            PositionExtern    => PositionExtern,
                                            FarbeExtern       => Sf.Graphics.Color.sfBlack,
                                            KreisAccessExtern => KreisAccess);
      end if;
      
   end RessourceZeichnen;
   
   
   
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      ------------------------- Hier mal ein bisschen Übersichtlicher gestalten.
      Wegfeld := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      if
        Wegfeld = KartenVerbesserungDatentypen.Leer_Weg_Enum
      then
         null;
         
      elsif
        EingeleseneTexturenSFML.WegeAccess (Wegfeld) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenWeltkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                      TextureAccessExtern => EingeleseneTexturenSFML.WegeAccess (Wegfeld)));
            
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.KartenfelderAbmessung.x, BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00),
                                               PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.80 * BerechnungenKarteSFML.KartenfelderAbmessung.y),
                                               FarbeExtern          => Sf.Graphics.Color.sfRed,
                                               RechteckAccessExtern => RechteckAccess);
      end if;
      
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Verbesserungsfeld := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      if
        Verbesserungsfeld = KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
      then
         null;
         
      elsif
        EingeleseneTexturenSFML.VerbesserungenAccess (Verbesserungsfeld) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  =>
                                                     TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenWeltkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                   TextureAccessExtern => EingeleseneTexturenSFML.VerbesserungenAccess (Verbesserungsfeld)));
            
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00, BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00),
                                               PositionExtern       => PositionExtern,
                                               FarbeExtern          => Sf.Graphics.Color.sfCyan,
                                               RechteckAccessExtern => RechteckAccess);
      end if;
      
   end VerbesserungZeichnen;
   
   
   
   procedure AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      case
        StadtRasseNummer.Nummer
      is
         when StadtKonstanten.LeerNummer =>
            return;
         
         when others =>
            Stadtart := LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummer);
      end case;
      
      ------------------- Eventuell kann man diese Sachen doch auslagern, wenn man die Skalierung mit übergibt, dann müsste man aber die Texture vorher festlegen. Und was ist dann mit den untexturierten Felder?
      if
        EingeleseneTexturenSFML.VerbesserungenAccess (Stadtart) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenWeltkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                      TextureAccessExtern => EingeleseneTexturenSFML.VerbesserungenAccess (Stadtart)));
         
      else
         case
           Stadtart
         is
            when KartenVerbesserungDatentypen.Eigene_Hauptstadt_Enum =>
               ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                                    PositionExtern      => PositionExtern,
                                                    AnzahlEckenExtern   => 5,
                                                    FarbeExtern         => GrafikEinstellungenSFML.RassenFarbenRahmen (StadtRasseNummer.Rasse),
                                                    PolygonAccessExtern => PolygonAccess);
               
            when KartenVerbesserungDatentypen.Eigene_Stadt_Enum =>
               ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 3.00,
                                                    PositionExtern      => PositionExtern,
                                                    AnzahlEckenExtern   => 6,
                                                    FarbeExtern         => GrafikEinstellungenSFML.RassenFarbenRahmen (StadtRasseNummer.Rasse),
                                                    PolygonAccessExtern => PolygonAccess);
               
            when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
               Fehler.GrafikFehler (FehlermeldungExtern => "KarteSFML.AnzeigeStadt - Vorhandene Stadt ist nicht vorhanden.");
         end case;
      end if;
      
   end AnzeigeStadt;
   
   
   
   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitRasseNummer.Nummer = EinheitenKonstanten.LeerNummer
      then
         null;
         
      elsif
        EingeleseneTexturenSFML.EinheitenAccess (RasseExtern, LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer)) /= null
      then
         KarteGrafikenZeichnenSFML.SpriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                   PositionExtern    => PositionExtern,
                                                   SkalierungExtern  => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenWeltkarte
                                                     (SpriteAccessExtern  => SpriteAccess,
                                                      TextureAccessExtern => EingeleseneTexturenSFML.EinheitenAccess (RasseExtern, LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer))));
         
         
      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummer) /= EinheitenKonstanten.LeerWirdTransportiert
      then
         ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.80,
                                              PositionExtern      => PositionExtern,
                                              AnzahlEckenExtern   => 4,
                                              FarbeExtern         => GrafikEinstellungenSFML.RassenFarbenRahmen (EinheitRasseNummer.Rasse),
                                              PolygonAccessExtern => PolygonAccess);
            
      else
         ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.80,
                                              PositionExtern      => PositionExtern,
                                              AnzahlEckenExtern   => 4,
                                              FarbeExtern         => GrafikEinstellungenSFML.RassenFarbenRahmen (EinheitRasseNummer.Rasse),
                                              PolygonAccessExtern => PolygonAccess);
      end if;
      
   end AnzeigeEinheit;
   
   
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      AktuelleRasse := LeseKarten.RasseBelegtGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        AktuelleRasse
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            null;
            
         when others =>
            RahmenBesetztesFeld (KoordinatenExtern => KoordinatenExtern,
                                 PositionExtern    => PositionExtern,
                                 RasseExtern       => AktuelleRasse);
      end case;
            
   end AnzeigeFeldbesitzer;
   
   
   
   procedure RahmenBesetztesFeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Sf.Graphics.RectangleShape.setSize (shape => RechteckBelegtesFeldAccess,
                                          size  => BerechnungenKarteSFML.KartenfelderAbmessung);
      Sf.Graphics.RectangleShape.setPosition (shape    => RechteckBelegtesFeldAccess,
                                              position => PositionExtern);
      Sf.Graphics.RectangleShape.setFillColor (shape => RechteckBelegtesFeldAccess,
                                               color => GrafikEinstellungenSFML.RassenFarben (RasseExtern));
      
      Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                   object       => RechteckBelegtesFeldAccess);
      
      UmgebungSchleife:
      for UmgebungSchleifenwert in UmgebungArray'Range loop
         
         KartenWertRahmen := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                    ÄnderungExtern    => Umgebung (UmgebungSchleifenwert),
                                                                                                    LogikGrafikExtern => False);
               
         if
           KartenWertRahmen.XAchse = KartenKonstanten.LeerXAchse
         then
            RahmenZeichnen (WelcheRichtungExtern => UmgebungSchleifenwert,
                            PositionExtern       => PositionExtern,
                            RasseExtern          => RasseExtern);
                     
         elsif
           RasseExtern /= LeseKarten.RasseBelegtGrund (KoordinatenExtern => KartenWertRahmen)
         then
            RahmenZeichnen (WelcheRichtungExtern => UmgebungSchleifenwert,
                            PositionExtern       => PositionExtern,
                            RasseExtern          => RasseExtern);

         else
            null;
         end if;
            
      end loop UmgebungSchleife;
      
      KartenWertStadtname := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                    ÄnderungExtern    => (0, -1, 0),
                                                                                                    LogikGrafikExtern => False);
      
      case
        KartenWertStadtname.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;
            
         when others =>
            StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KartenWertStadtname);
            
            if
              StadtRasseNummer.Nummer = StadtKonstanten.LeerNummer
            then
               return;
               
            else
               null;
            end if;
      end case;
      
      -- Möglicherweise die Schriftfarbe durch die Rahmenfarbe ersetzen? Die Belegungsfarbe ist auf jeden Fall ungeeignet.
      -- Text wird von den anderen Feldern immer wieder überschrieben. Eventuell ein zweites Mal über die ganzen Felder gehen?
      -- Wenn ich das ganze als View anlege, die Städtenamen da rein schreibe und den dann am Schluss anzeige, müsste das nicht gehen?
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAccess,
                                         str  => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummer)));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAccess,
                                    position => PositionExtern);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.KarteAccess);
      
   end RahmenBesetztesFeld;



   procedure RahmenZeichnen
     (WelcheRichtungExtern : in Umgebung_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Sf.Graphics.RectangleShape.setFillColor (shape => RechteckRahmenAccess,
                                               color => GrafikEinstellungenSFML.RassenFarbenRahmen (RasseExtern));
      
      case
        WelcheRichtungExtern
      is
         when Norden =>
            Sf.Graphics.RectangleShape.setSize (shape => RechteckRahmenAccess,
                                                size  => (BerechnungenKarteSFML.KartenfelderAbmessung.x, DickeRahmen));
            Sf.Graphics.RectangleShape.setPosition (shape    => RechteckRahmenAccess,
                                                    position => PositionExtern);
         
         when Westen =>
            Sf.Graphics.RectangleShape.setSize (shape => RechteckRahmenAccess,
                                                size  => (DickeRahmen, BerechnungenKarteSFML.KartenfelderAbmessung.y));
            Sf.Graphics.RectangleShape.setPosition (shape    => RechteckRahmenAccess,
                                                    position => PositionExtern);
         
         when Osten =>
            Sf.Graphics.RectangleShape.setSize (shape => RechteckRahmenAccess,
                                                size  => (DickeRahmen, BerechnungenKarteSFML.KartenfelderAbmessung.y));
            Sf.Graphics.RectangleShape.setPosition (shape    => RechteckRahmenAccess,
                                                    position => (PositionExtern.x + BerechnungenKarteSFML.KartenfelderAbmessung.x - DickeRahmen, PositionExtern.y));
         
         when Süden =>
            Sf.Graphics.RectangleShape.setSize (shape => RechteckRahmenAccess,
                                                size  => (BerechnungenKarteSFML.KartenfelderAbmessung.x, DickeRahmen));
            Sf.Graphics.RectangleShape.setPosition (shape    => RechteckRahmenAccess,
                                                    position => (PositionExtern.x, PositionExtern.y + BerechnungenKarteSFML.KartenfelderAbmessung.y - DickeRahmen));
      end case;
            
      Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                   object       => RechteckRahmenAccess);
      
   end RahmenZeichnen;
   
   
   
   procedure AnzeigeCursor
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      if
        KoordinatenExtern = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell
      then
         ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                              PositionExtern      => PositionExtern,
                                              AnzahlEckenExtern   => 3,
                                              FarbeExtern         => Sf.Graphics.Color.sfRed,
                                              PolygonAccessExtern => PolygonAccess);
         
      else
         null;
      end if;
      
   end AnzeigeCursor;

end KarteSFML;
