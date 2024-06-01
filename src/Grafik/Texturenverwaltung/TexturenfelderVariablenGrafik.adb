package body TexturenfelderVariablenGrafik is

   function Basisgrundbereich
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Basisgrund (BasisgrundExtern);
      
   end Basisgrundbereich;
   
   
   
   function Basisgrundabmessung
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Basisgrundabmessung;
   
   
   
   function Zusatzgrundbereich
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Zusatzgrund (ZusatzgrundExtern);
      
   end Zusatzgrundbereich;
   
   
   
   function Zusatzgrundabmessung
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Zusatzgrund (ZusatzgrundExtern).width), Float (Zusatzgrund (ZusatzgrundExtern).height));
      
   end Zusatzgrundabmessung;
   
   
   
   function Flussbereich
     (FlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Flüsse (FlussExtern);
      
   end Flussbereich;
   
   
   
   function Flussabmessung
     (FlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Flüsse (FlussExtern).width), Float (Flüsse (FlussExtern).height));
      
   end Flussabmessung;
   
   
   
   function Ressourcenbereich
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Ressourcen (RessourceExtern);
      
   end Ressourcenbereich;
   
   
   
   function Ressourcenabmessung
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Ressourcen (RessourceExtern).width), Float (Ressourcen (RessourceExtern).height));
      
   end Ressourcenabmessung;
   
   
   
   function Verbesserungsbereich
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Verbesserungen (VerbesserungExtern);
      
   end Verbesserungsbereich;
   
   
   
   function Verbesserungsabmessung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Verbesserungen (VerbesserungExtern).width), Float (Verbesserungen (VerbesserungExtern).height));
      
   end Verbesserungsabmessung;
   
   
   
   function Wegebereich
     (WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Wege (WegExtern);
      
   end Wegebereich;
   
   
   
   function Wegeabmessung
     (WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Wege (WegExtern).width), Float (Wege (WegExtern).height));
      
   end Wegeabmessung;
   
   
   
   function Feldeffektebereich
     (FeldeffektedExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Feldeffekte (FeldeffektedExtern);
      
   end Feldeffektebereich;
   
   
   
   function Feldeffekteabmessung
     (FeldeffektedExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Feldeffekte (FeldeffektedExtern).width), Float (Feldeffekte (FeldeffektedExtern).height));
      
   end Feldeffekteabmessung;
   
   
   
   function Hintergrundbereich
     (HintergrundExtern : in GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Hintergründe (SpeziesExtern, HintergrundExtern);
      
   end Hintergrundbereich;
   
   
   
   function Hintergrundabmessung
     (HintergrundExtern : in GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Hintergründe (SpeziesExtern, HintergrundExtern).width), Float (Hintergründe (SpeziesExtern, HintergrundExtern).height));
      
   end Hintergrundabmessung;
   
   
   -- Einheiten/Gebäude und Spezies in den gemeinsamen Record umwandeln. äöü
   
   function Einheitenbereich
     (EinheitExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Einheiten (SpeziesExtern, EinheitExtern);
      
   end Einheitenbereich;
   
   
   
   function Einheitenabmessung
     (EinheitExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Einheiten (SpeziesExtern, EinheitExtern).width), Float (Einheiten (SpeziesExtern, EinheitExtern).height));
      
   end Einheitenabmessung;
   
   
   
   function Gebäudebereich
     (GebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Gebäude (SpeziesExtern, GebäudeExtern);
      
   end Gebäudebereich;
   
   
   
   function Gebäudeabmessung
     (GebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Gebäude (SpeziesExtern, GebäudeExtern).width), Float (Gebäude (SpeziesExtern, GebäudeExtern).height));
      
   end Gebäudeabmessung;
   
end TexturenfelderVariablenGrafik;
