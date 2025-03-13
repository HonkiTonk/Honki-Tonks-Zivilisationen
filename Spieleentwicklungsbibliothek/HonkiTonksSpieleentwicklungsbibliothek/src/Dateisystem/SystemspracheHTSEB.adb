with Ada.Directories;

with TextKonstantenHTSEB;

with UmwandlungssystemHTSEB;

package body SystemspracheHTSEB is

   function Systemsprache
     return Unbounded_Wide_Wide_String
   is
      use Ada.Locales;
   begin
      
      LokaleSprache := Ada.Locales.Language;
      
      if
        LokaleSprache = Ada.Locales.Language_Unknown
      then
         return TextKonstantenHTSEB.LeerUnboundedString;
         
      else
         null;
      end if;
      
      SprachenSchleife:
      for SprachenSchleifenwert in StandardsprachenArray'Range loop
         
         if
           LokaleSprache = Standardsprachen (SprachenSchleifenwert).ISONummer
         then
            return Existenzprüfung (OrdnernameExtern => Standardsprachen (SprachenSchleifenwert).Sprache);
            
         else
            null;
         end if;
         
      end loop SprachenSchleife;
            
      return TextKonstantenHTSEB.LeerUnboundedString;
      
   end Systemsprache;
   
   
   
   function Existenzprüfung
     (OrdnernameExtern : in Unbounded_Wide_Wide_String)
     return Unbounded_Wide_Wide_String
   is
      use Ada.Directories;
   begin
      
      case
        Exists (Name => "Sprachen/" & UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => OrdnernameExtern))
      is
         when True =>
            return OrdnernameExtern;
            
         when False =>
            return TextKonstantenHTSEB.LeerUnboundedString;
      end case;
      
   end Existenzprüfung;

end SystemspracheHTSEB;
