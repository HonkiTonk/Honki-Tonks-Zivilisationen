pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;
with Sf.Window.VideoMode;

with SonstigesKonstanten;

with EinstellungenGrafik;
with AllgemeinGrafik;
with Fehler;
with TexteinstellungenGrafik;

package body StartEndeGrafik is

   procedure FensterErzeugen
   is begin
      
      FensterErzeugenErweitert;

      if
        EinstellungenGrafik.FensterAccess = null
      then
         Fehler.GrafikFehler (FehlermeldungExtern => "StartEndeGrafik.FensterErzeugen: FensterAccess = null.");

      else
         AllgemeinGrafik.MauszeigerFestlegen;
         AllgemeinGrafik.BildrateÄndern;
         TexteinstellungenGrafik.SchriftartFestlegen;
         AllgemeinGrafik.AktuelleAuflösungFestlegen;
      end if;
      
   end FensterErzeugen;
   
   
   
   procedure FensterErzeugenErweitert
   is begin
      
      case
        EinstellungenGrafik.FensterEinstellungen.FensterVollbild
      is
         when 7 =>
            EinstellungenGrafik.FensterAccess := Sf.Graphics.RenderWindow.createUnicode (mode  => (EinstellungenGrafik.FensterEinstellungen.FensterBreite,
                                                                                                       EinstellungenGrafik.FensterEinstellungen.FensterHöhe,
                                                                                                       EinstellungenGrafik.FensterEinstellungen.Farbtiefe),
                                                                                             title => SonstigesKonstanten.Spielname,
                                                                                             style => EinstellungenGrafik.FensterEinstellungen.FensterVollbild);
            
            -- Die Vollbildauflösung noch seperat speichern? äöü
         when 8 =>
            EinstellungenGrafik.FensterAccess := Sf.Graphics.RenderWindow.createUnicode (mode  => (Sf.Window.VideoMode.getDesktopMode.width,
                                                                                                       Sf.Window.VideoMode.getDesktopMode.height,
                                                                                                       EinstellungenGrafik.FensterEinstellungen.Farbtiefe),
                                                                                             title => SonstigesKonstanten.Spielname,
                                                                                             style => EinstellungenGrafik.FensterEinstellungen.FensterVollbild);
            
         when others =>
            Fehler.GrafikFehler (FehlermeldungExtern => "StartEndeGrafik.FensterErzeugenErweitert: Unbekannter Fenstermodus: " & EinstellungenGrafik.FensterEinstellungen.FensterVollbild'Wide_Wide_Image);
      end case;
            
   end FensterErzeugenErweitert;
   
   
   
   procedure FensterEntfernen
   is begin
      
      Sf.Graphics.RenderWindow.destroy (renderWindow => EinstellungenGrafik.FensterAccess);
      
   end FensterEntfernen;
   
   
   
   procedure FensterLeeren
   is begin
      
      Sf.Graphics.RenderWindow.clear (renderWindow => EinstellungenGrafik.FensterAccess,
                                      color        => Sf.Graphics.Color.sfBlack);
      
   end FensterLeeren;
   
   
   
   procedure FensterAnzeigen
   is begin
      
      Sf.Graphics.RenderWindow.display (renderWindow => EinstellungenGrafik.FensterAccess);
      
   end FensterAnzeigen;
  
end StartEndeGrafik;
