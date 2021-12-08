pragma SPARK_Mode (On);

with GlobaleVariablen;

with EingabeKonsole;
with EingabeSFML;

package body Eingabe is

   function GanzeZahl
     (ZeileExtern : in Positive;
      ZahlenMinimumExtern : in Integer;
      ZahlenMaximumExtern : in Integer)
      return SystemRecords.ZahlenEingabeRecord
   is begin
      
      -- TextDateiExtern später auch in Konsole entfernen. Und alle Fragen nach Fragen verschieben, sonst funktioniert das hier nicht so richtig. Ist auch sinnvollder aufgeteilt dann.
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return EingabeKonsole.GanzeZahl (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                             ZahlenMaximumExtern => ZahlenMaximumExtern,
                                             WelcheFrageExtern   => ZeileExtern);
            
         when SystemDatentypen.SFML =>
            return EingabeSFML.GanzeZahl (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                          ZahlenMaximumExtern => ZahlenMaximumExtern,
                                          WelcheFrageExtern   => ZeileExtern);
      end case;
      
   end GanzeZahl;

   

   function StadtName
     return SystemRecords.TextEingabeRecord
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return EingabeKonsole.StadtName;
            
         when SystemDatentypen.SFML =>
            return EingabeSFML.StadtName;
      end case;
      
   end StadtName;



   function SpielstandName
     return SystemRecords.TextEingabeRecord
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return EingabeKonsole.SpielstandName;
            
         when SystemDatentypen.SFML =>
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
            
         when SystemDatentypen.SFML =>
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
            
         when SystemDatentypen.SFML =>
            return EingabeSFML.Tastenwert;
      end case;
      
   end Tastenwert;
   
   
   
   procedure StandardTastenbelegungLaden
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            EingabeKonsole.StandardTastenbelegungLaden;
            
         when SystemDatentypen.SFML =>
            EingabeSFML.StandardTastenbelegungLaden;
      end case;
      
   end StandardTastenbelegungLaden;

end Eingabe;
