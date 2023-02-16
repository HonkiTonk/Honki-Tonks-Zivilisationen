package body SpezieseinstellungenGrafik is

   procedure StandardLaden
   is begin
      
      Speziesfarben := SpeziesfarbenStandard;
      SpeziesfarbenRahmen := SpeziesfarbenRahmenStandard;
      
   end StandardLaden;
   
   
   
   procedure FarbenarraySchreiben
     (FarbenExtern : in SpeziesFarbenArray)
   is begin
      
      Speziesfarben := FarbenExtern;
      
   end FarbenarraySchreiben;
   
   
   
   procedure RahmenarraySchreiben
     (FarbenExtern : in SpeziesFarbenArray)
   is begin
      
      SpeziesfarbenRahmen := FarbenExtern;
      
   end RahmenarraySchreiben;
   
   
   
   function SpeziesfarbeLesen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      return Speziesfarben (SpeziesExtern);
      
   end SpeziesfarbeLesen;
   
   
   
   function RahmenfarbeLesen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      return SpeziesfarbenRahmen (SpeziesExtern);
      
   end RahmenfarbeLesen;
   
   
   
   function FarbenarrayLesen
     return SpeziesFarbenArray
   is begin
      
      return Speziesfarben;
      
   end FarbenarrayLesen;
   
   
   
   function RahmenarrayLesen
     return SpeziesFarbenArray
   is begin
      
      return SpeziesfarbenRahmen;
      
   end RahmenarrayLesen;

end SpezieseinstellungenGrafik;
