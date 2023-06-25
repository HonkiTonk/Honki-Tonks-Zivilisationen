with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Strings.Wide_Wide_Fixed;

package body UmwandlungenAdaNachEigenes is
   
   -- Wieso Unbounded_Wide_Wide_String? Müsste Wide_Wide_String nicht auch gehen? Wenn nicht dann mal eine Wide_Wide_String Variante bauen. äöü
   function ZahlAlsStringLeerzeichenEntfernen
     (ZahlExtern : in GanzeZahl)
      return Unbounded_Wide_Wide_String
   is begin
      
      if
        ZahlExtern >= 0
      then
         Zahlenstring := To_Unbounded_Wide_Wide_String (Source => Ada.Strings.Wide_Wide_Fixed.Trim (Source => ZahlExtern'Wide_Wide_Image,
                                                                                                    Side   => Ada.Strings.Left));
         
      else
         Zahlenstring := To_Unbounded_Wide_Wide_String (Source => ZahlExtern'Wide_Wide_Image);
      end if;
      
      return Zahlenstring;
      
   end ZahlAlsStringLeerzeichenEntfernen;
   
   
   
   function FloatAlsString
     (KampfbonusExtern : in KampfDatentypen.Kampfbonus)
      return Wide_Wide_String
   is
      use type KampfDatentypen.Kampfbonus;
   begin
      
      Put (To   => Kommazahlenstring,
           Item => Float (KampfbonusExtern),
           Aft  => 2,
           Exp  => 0);
      
      -- Hier später noch eine Prüfung einbauen ob ein Punkt oder ein Komma als Trennung genutzt werden soll. äöü
      -- Das auch eventuell für Tausenderstellen einbauen? äöü
      -- Kommazahlenstring := PunktNachKomma (ZahlenstringExtern => Kommazahlenstring);
      
      if
        KampfbonusExtern = KampfDatentypen.Kampfbonus'Last
      then
         return " " & Decode (Item => Kommazahlenstring);
         
      else
         return Decode (Item => Kommazahlenstring);
      end if;
      
   end FloatAlsString;
   
   
   
   function PunktNachKomma
     (ZahlenstringExtern : in String)
      return String
   is begin
      
      Zwischenspeicher := ZahlenstringExtern;
      
      ZahlenSchleife:
      for ZahlenSchleifenwert in Zwischenspeicher'Range loop
         
         case
           Zwischenspeicher (ZahlenSchleifenwert)
         is
            when '.' =>
               Zwischenspeicher (ZahlenSchleifenwert) := ',';
               exit ZahlenSchleife;
               
            when others =>
               null;
         end case;
         
      end loop ZahlenSchleife;
      
      return Zwischenspeicher;
      
   end PunktNachKomma;

end UmwandlungenAdaNachEigenes;
