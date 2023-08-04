with Fehlermeldungssystem;

package body AllgemeineBerechnungen is

   function FreieEinwohner
     (EinwohnerExtern : in StadtDatentypen.Einwohner;
      ArbeiterExtern : in StadtDatentypen.Einwohner)
      return StadtDatentypen.Einwohner
   is begin
      
      if
        ArbeiterExtern > EinwohnerExtern
      then
         Fehlermeldungssystem.Mehrfachverwendung (FehlermeldungExtern => "AllgemeineBerechnungen.FreieEinwohner: Einwohner < Arbeiter:" & EinwohnerExtern'Wide_Wide_Image & "," & ArbeiterExtern'Wide_Wide_Image);
         return StadtDatentypen.Einwohner'First;
         
      else
         return EinwohnerExtern - ArbeiterExtern;
      end if;
      
   end FreieEinwohner;
   
   
   
   function Basiszeitwert
     (ZusatzwertExtern : in GanzeZahl;
      TeilerExtern : in GanzeZahl)
      return GanzeZahl
   is begin
      
      return (ZusatzwertExtern + (TeilerExtern - 1)) / TeilerExtern;
      
   end Basiszeitwert;

end AllgemeineBerechnungen;
