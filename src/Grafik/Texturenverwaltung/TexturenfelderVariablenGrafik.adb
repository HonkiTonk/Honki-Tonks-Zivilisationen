package body TexturenfelderVariablenGrafik is

   function BasisgrundRechteck
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Basisgrund (BasisgrundExtern);
      
   end BasisgrundRechteck;
   
   
   
   function BasisgrundVektor
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end BasisgrundVektor;
   
   
   
   function ZusatzgrundRechteck
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Zusatzgrund (ZusatzgrundExtern);
      
   end ZusatzgrundRechteck;
   
   
   
   function ZusatzgrundVektor
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Zusatzgrund (ZusatzgrundExtern).width), Float (Zusatzgrund (ZusatzgrundExtern).height));
      
   end ZusatzgrundVektor;
   
   
   
   function FlussRechteck
     (FlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Flüsse (FlussExtern);
      
   end FlussRechteck;
   
   
   
   function FlussVektor
     (FlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Flüsse (FlussExtern).width), Float (Flüsse (FlussExtern).height));
      
   end FlussVektor;
   
   
   
   function RessourcenRechteck
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Ressourcen (RessourceExtern);
      
   end RessourcenRechteck;
   
   
   
   function RessourcenVektor
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Ressourcen (RessourceExtern).width), Float (Ressourcen (RessourceExtern).height));
      
   end RessourcenVektor;
   
   
   
   function VerbesserungRechteck
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Verbesserungen (VerbesserungExtern);
      
   end VerbesserungRechteck;
   
   
   
   function VerbesserungVektor
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Verbesserungen (VerbesserungExtern).width), Float (Verbesserungen (VerbesserungExtern).height));
      
   end VerbesserungVektor;
   
   
   
   function WegeRechteck
     (WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Wege (WegExtern);
      
   end WegeRechteck;
   
   
   
   function WegeVektor
     (WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Wege (WegExtern).width), Float (Wege (WegExtern).height));
      
   end WegeVektor;
   
   
   
   function FeldeffekteRechteck
     (FeldeffektedExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Feldeffekte (FeldeffektedExtern);
      
   end FeldeffekteRechteck;
   
   
   
   function FeldeffekteVektor
     (FeldeffektedExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Feldeffekte (FeldeffektedExtern).width), Float (Feldeffekte (FeldeffektedExtern).height));
      
   end FeldeffekteVektor;
   
   
   
   function AllgemeinesSpezienRechteck
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Spezienspezifisch_Anzeige_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return AllgemeinesSpezien (SpeziesExtern, HintergrundExtern);
      
   end AllgemeinesSpezienRechteck;
   
   
   
   function AllgemeinesSpezienVektor
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Spezienspezifisch_Anzeige_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (AllgemeinesSpezien (SpeziesExtern, HintergrundExtern).width), Float (AllgemeinesSpezien (SpeziesExtern, HintergrundExtern).height));
      
   end AllgemeinesSpezienVektor;
   
   
   
   -- Einheiten/Gebäude und Spezies in den gemeinsamen Record umwandeln. äöü
   function EinheitenRechteck
     (EinheitExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Einheiten (SpeziesExtern, EinheitExtern);
      
   end EinheitenRechteck;
   
   
   
   function EinheitenVektor
     (EinheitExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Einheiten (SpeziesExtern, EinheitExtern).width), Float (Einheiten (SpeziesExtern, EinheitExtern).height));
      
   end EinheitenVektor;
   
   
   
   function GebäudeRechteck
     (GebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Gebäude (SpeziesExtern, GebäudeExtern);
      
   end GebäudeRechteck;
   
   
   
   function GebäudeVektor
     (GebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Gebäude (SpeziesExtern, GebäudeExtern).width), Float (Gebäude (SpeziesExtern, GebäudeExtern).height));
      
   end GebäudeVektor;
   
   
   
   function AllgemeinesRechteck
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Gesamt_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      case
        HintergrundExtern
      is
         when GrafikDatentypen.Hintergrund_Intro_Enum'Range =>
            return Intro (HintergrundExtern);
            
         when GrafikDatentypen.Hintergrund_Kartenformen_Enum'Range =>
            return Kartenformen (HintergrundExtern);
            
         when GrafikDatentypen.Hintergrund_Einheitenbefehle_Enum'Range =>
            null;
            
         when GrafikDatentypen.Hintergrund_Anzeige_Enum'Range =>
            return Allgemeines (HintergrundExtern);
            
         when GrafikDatentypen.Hintergrund_Spezienspezifisch_Anzeige_Enum'Range =>
            return AllgemeinesSpezien (SpeziesExtern, HintergrundExtern);
            
         when GrafikDatentypen.Hintergrund_Outro_Enum'Range =>
            null;
      end case;
      
      return (1, 1, 1, 1);
      
   end AllgemeinesRechteck;
   
   
   
   function AllgemeinesVektor
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Gesamt_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      case
        HintergrundExtern
      is
         when GrafikDatentypen.Hintergrund_Intro_Enum'Range =>
            return (Float (Intro (HintergrundExtern).width), Float (Intro (HintergrundExtern).height));
            
         when GrafikDatentypen.Hintergrund_Kartenformen_Enum'Range =>
            return (Float (Kartenformen (HintergrundExtern).width), Float (Kartenformen (HintergrundExtern).height));
            
         when GrafikDatentypen.Hintergrund_Einheitenbefehle_Enum'Range =>
            null;
            
         when GrafikDatentypen.Hintergrund_Anzeige_Enum'Range =>
            return (Float (Allgemeines (HintergrundExtern).width), Float (Allgemeines (HintergrundExtern).height));
            
         when GrafikDatentypen.Hintergrund_Spezienspezifisch_Anzeige_Enum'Range =>
            return (Float (AllgemeinesSpezien (SpeziesExtern, HintergrundExtern).width), Float (AllgemeinesSpezien (SpeziesExtern, HintergrundExtern).height));
                        
         when GrafikDatentypen.Hintergrund_Outro_Enum'Range =>
            null;
      end case;
      
      return (1.00, 1.00);
      
   end AllgemeinesVektor;
   
   
   
   function KartenbefehleRechteck
     (BefehlExtern : in TastenbelegungDatentypen.Kartenbefehle_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Kartenbefehle (BefehlExtern);
      
   end KartenbefehleRechteck;
   
   
   
   function KartenbefehleVektor
     (BefehlExtern : in TastenbelegungDatentypen.Kartenbefehle_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Kartenbefehle (BefehlExtern).width), Float (Kartenbefehle (BefehlExtern).height));
      
   end KartenbefehleVektor;
   
   
   
   function EinheitenbefehleRechteck
     (BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Einheitenbefehle (BefehlExtern);
      
   end EinheitenbefehleRechteck;
   
   
   
   function EinheitenbefehleVektor
     (BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Einheitenbefehle (BefehlExtern).width), Float (Einheitenbefehle (BefehlExtern).height));
      
   end EinheitenbefehleVektor;
   
end TexturenfelderVariablenGrafik;
