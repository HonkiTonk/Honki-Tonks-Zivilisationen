with Ada.Real_Time; use Ada.Real_Time;

package ZeitKonstanten is
   pragma Elaborate_Body;
   
   WartezeitStart : constant Time_Span := Milliseconds (2);
   
   -- Wird das so überhaupt benötigt?
   WartezeitLogik : constant Time_Span := Milliseconds (2);
   WartezeitGrafik : constant Time_Span := Milliseconds (2);
   WartezeitMusik : constant Time_Span := Milliseconds (2);
   WartezeitSound : constant Time_Span := Milliseconds (2);

   WartezeitEingabe : constant Time_Span := Milliseconds (2);
   
   -- Intervalle durch Nutzer einstellen lassen? äöü
   Blinkintervall : constant Time_Span := Milliseconds (500);
   
   -- Das hier vom Nutzer einstellbar machen. äöü
   AnzeigezeitSpielmeldungen : constant Time_Span := Milliseconds (2_000);
   
   -- Das hier vom Nutzer einstellbar machen. äöü
   Scrollverzögerung : constant Time_Span := Milliseconds (20);
   ScrollverzögernMinimalzoom : constant Time_Span := Milliseconds (50);
   
   Introzeit : constant Time_Span := Milliseconds (5_000);
   
end ZeitKonstanten;
