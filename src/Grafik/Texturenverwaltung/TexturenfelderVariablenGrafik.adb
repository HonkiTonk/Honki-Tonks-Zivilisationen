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
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Zusatzgrundabmessung
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Flussbereich
     (FlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Flussabmessung
     (FlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Ressourcenbereich
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Ressourcenabmessung
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Verbesserungsbereich
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Verbesserungsabmessung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Wegebereich
     (WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Wegeabmessung
     (WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Feldeffektebereich
     (FeldeffektedExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Feldeffekteabmessung
     (FeldeffektedExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Hintergrundbereich
     (HintergrundExtern : in GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Hintergrundabmessung
     (HintergrundExtern : in GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Einheitenbereich
     (EinheitExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Einheitenabmessung
     (EinheitExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Gebäudebereich
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
   
   
   function Gebäudeabmessung
     (GebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Zusatzgrundbereich;
   
end TexturenfelderVariablenGrafik;
