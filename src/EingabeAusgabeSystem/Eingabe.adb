pragma SPARK_Mode (On);

with GlobaleVariablen;

with EingabeKonsole;
with EingabeSFML;

package body Eingabe is

   function GanzeZahl
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern : in Integer;
      ZahlenMaximumExtern : in Integer)
      return Integer
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return EingabeKonsole.GanzeZahl (TextDateiExtern     => TextDateiExtern,
                                             ZeileExtern         => ZeileExtern,
                                             ZahlenMinimumExtern => ZahlenMinimumExtern,
                                             ZahlenMaximumExtern => ZahlenMaximumExtern);
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            return EingabeSFML.GanzeZahl (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                          ZahlenMaximumExtern => ZahlenMaximumExtern,
                                          WelcheFrageExtern   => ZeileExtern);
      end case;
      
   end GanzeZahl;

   

   function StadtName
     return Unbounded_Wide_Wide_String
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return EingabeKonsole.StadtName;
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            return EingabeSFML.StadtName;
      end case;
      
   end StadtName;



   function SpielstandName
     return Unbounded_Wide_Wide_String
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return EingabeKonsole.SpielstandName;
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            return EingabeSFML.SpielstandName;
      end case;
      
   end SpielstandName;



   procedure WartenEingabe
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            EingabeKonsole.WartenEingabe;
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            EingabeSFML.WartenEingabe;
      end case;
      
   end WartenEingabe;
   
   
   
   function Tastenwert
     return SystemDatentypen.Tastenbelegung_Enum
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return EingabeKonsole.Tastenwert;
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            return EingabeSFML.Tastenwert;
      end case;
      
   end Tastenwert;
   
   
   
   function BefehlEingabe
      return SystemDatentypen.Tastenbelegung_Enum
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return EingabeKonsole.Tastenwert;
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            return EingabeSFML.BefehlEingabe;
      end case;
      
   end BefehlEingabe;
   
   
   
   procedure StandardTastenbelegungLaden
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            EingabeKonsole.StandardTastenbelegungLaden;
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            EingabeSFML.StandardTastenbelegungLaden;
      end case;
      
   end StandardTastenbelegungLaden;

end Eingabe;
