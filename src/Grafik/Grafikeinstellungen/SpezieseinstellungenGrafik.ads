with Sf.Graphics.Color;

with SpeziesDatentypen;

package SpezieseinstellungenGrafik is
   pragma Elaborate_Body;
   
   -- Das hier in Records verschieben? äöü
   type SpeziesFarbenArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of Sf.Graphics.Color.sfColor;
   
   procedure StandardLaden;
   
   procedure FarbenarraySchreiben
     (FarbenExtern : in SpeziesFarbenArray);
      
   procedure RahmenarraySchreiben
     (FarbenExtern : in SpeziesFarbenArray);
   
   
   
   function SpeziesfarbeLesen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Sf.Graphics.Color.sfColor;
   
   function RahmenfarbeLesen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Sf.Graphics.Color.sfColor;
   
   function FarbenarrayLesen
     return SpeziesFarbenArray;
   
   function RahmenarrayLesen
     return SpeziesFarbenArray;
   
private
   
   Speziesfarben : SpeziesFarbenArray;
   SpeziesfarbenRahmen : SpeziesFarbenArray;
      
   SpeziesfarbenStandard : constant SpeziesFarbenArray := (
                                                           SpeziesDatentypen.Menschen_Enum         => (255, 230, 200, 75),
                                                           SpeziesDatentypen.Kasrodiah_Enum        => (255, 100, 40, 75),
                                                           SpeziesDatentypen.Lasupin_Enum          => (65, 145, 140, 75),
                                                           SpeziesDatentypen.Lamustra_Enum         => (60, 255, 240, 75),
                                                           SpeziesDatentypen.Manuky_Enum           => (255, 255, 30, 75),
                                                           SpeziesDatentypen.Suroka_Enum           => (135, 10, 255, 75),
                                                           SpeziesDatentypen.Pryolon_Enum          => (65, 50, 15, 75),
                                                           SpeziesDatentypen.Talbidahr_Enum        => (255, 20, 255, 75),
                                                           SpeziesDatentypen.Moru_Phisihl_Enum     => (255, 255, 180, 75),
                                                           SpeziesDatentypen.Larinos_Lotaris_Enum  => (255, 210, 135, 75),
                                                           SpeziesDatentypen.Carupex_Enum          => (210, 210, 210, 75),
                                                           SpeziesDatentypen.Alary_Enum            => (165, 105, 0, 75),
                                                           SpeziesDatentypen.Tesorahn_Enum         => (10, 60, 240, 75),
                                                           SpeziesDatentypen.Natries_Zermanis_Enum => (170, 120, 130, 75),
                                                           SpeziesDatentypen.Tridatus_Enum         => (20, 95, 20, 75),
                                                           SpeziesDatentypen.Senelari_Enum         => (0, 210, 0, 75),
                                                           SpeziesDatentypen.Aspari_2_Enum         => (90, 90, 90, 75),
                                                           SpeziesDatentypen.Ekropa_Enum           => (255, 30, 30, 75)
                                                          );
   
   SpeziesfarbenRahmenStandard : constant SpeziesFarbenArray := (
                                                                 SpeziesDatentypen.Menschen_Enum         => (255, 230, 200, 255),
                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (255, 100, 40, 255),
                                                                 SpeziesDatentypen.Lasupin_Enum          => (65, 145, 140, 255),
                                                                 SpeziesDatentypen.Lamustra_Enum         => (60, 255, 240, 255),
                                                                 SpeziesDatentypen.Manuky_Enum           => (255, 255, 30, 255),
                                                                 SpeziesDatentypen.Suroka_Enum           => (135, 10, 255, 255),
                                                                 SpeziesDatentypen.Pryolon_Enum          => (65, 50, 15, 255),
                                                                 SpeziesDatentypen.Talbidahr_Enum        => (255, 20, 255, 255),
                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (255, 255, 180, 255),
                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (255, 210, 135, 255),
                                                                 SpeziesDatentypen.Carupex_Enum          => (210, 210, 210, 255),
                                                                 SpeziesDatentypen.Alary_Enum            => (165, 105, 0, 255),
                                                                 SpeziesDatentypen.Tesorahn_Enum         => (10, 60, 240, 255),
                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (170, 120, 130, 255),
                                                                 SpeziesDatentypen.Tridatus_Enum         => (20, 95, 20, 255),
                                                                 SpeziesDatentypen.Senelari_Enum         => (0, 210, 0, 255),
                                                                 SpeziesDatentypen.Aspari_2_Enum         => (90, 90, 90, 255),
                                                                 SpeziesDatentypen.Ekropa_Enum           => (255, 30, 30, 255)
                                                                );

end SpezieseinstellungenGrafik;
