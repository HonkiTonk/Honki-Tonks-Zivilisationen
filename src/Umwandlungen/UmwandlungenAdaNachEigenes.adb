with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Strings.Wide_Wide_Fixed;

with LeseOptionen;

-- Eventuell noch ein Zeichen für tausender Stellen hinzufügen? äöü
package body UmwandlungenAdaNachEigenes is
   
   function ZahlAlsString
     (ZahlExtern : in GanzeZahl)
      return Wide_Wide_String
   is begin
      
      if
        ZahlExtern >= 0
      then
         return Ada.Strings.Wide_Wide_Fixed.Trim (Source => ZahlExtern'Wide_Wide_Image,
                                                  Side   => Ada.Strings.Left);
         
      else
         return ZahlExtern'Wide_Wide_Image;
      end if;
      
   end ZahlAlsString;
   
   
   
   function KommazahlAlsString
     (KommazahlExtern : in Kommazahl)
      return Wide_Wide_String
   is begin
      
      Put (To   => Kommazahlenstring,
           Item => Float (KommazahlExtern),
           Aft  => 2,
           Exp  => 0);
            
      return Ada.Strings.Wide_Wide_Fixed.Trim (Source => PunktOderKomma (ZahlenstringExtern => Decode (Item => Kommazahlenstring)),
                                               Side   => Ada.Strings.Left);
      
   end KommazahlAlsString;
   
   
   
   function PunktOderKomma
     (ZahlenstringExtern : in Wide_Wide_String)
      return Wide_Wide_String
   is begin
      
      Zwischenspeicher := ZahlenstringExtern;
      
      ZahlenSchleife:
      for ZahlenSchleifenwert in Zwischenspeicher'Range loop
         
         case
           Zwischenspeicher (ZahlenSchleifenwert)
         is
            when '.' =>
               Zwischenspeicher (ZahlenSchleifenwert) := LeseOptionen.Dezimaltrennzeichen;
               exit ZahlenSchleife;
               
            when others =>
               null;
         end case;
         
      end loop ZahlenSchleife;
      
      return Zwischenspeicher;
      
   end PunktOderKomma;

end UmwandlungenAdaNachEigenes;
