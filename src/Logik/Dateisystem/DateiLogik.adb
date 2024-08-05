-- Eine Prozedur für das Schließen einzubauen ist sinnfrei.
-- Es gibt keine verschiedenen Varianten des Schließens und den Paketzugriff bekomme ich auch nicht raus, da ich ja immer noch das File_Type aus dem Standardpaket brauche.
with Projekteinstellungen;
with SystemDatentypen;

package body DateiLogik is
   
   procedure ErstellenStream
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in String)
   is begin
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when SystemDatentypen.Windows_Enum =>
            Ada.Streams.Stream_IO.Create (File => DateiartExtern,
                                          Mode => Ada.Streams.Stream_IO.Out_File,
                                          Name => NameExtern,
                                          Form => "WCEM=b");
            
         when SystemDatentypen.Linux_Enum =>
            Ada.Streams.Stream_IO.Create (File => DateiartExtern,
                                          Mode => Ada.Streams.Stream_IO.Out_File,
                                          Name => NameExtern,
                                          Form => "WCEM=8");
      end case;
      
   end ErstellenStream;
   
   

   procedure ÖffnenStream
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in String)
   is begin
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when SystemDatentypen.Windows_Enum =>
            Ada.Streams.Stream_IO.Open (File => DateiartExtern,
                                        Mode => Ada.Streams.Stream_IO.In_File,
                                        Name => NameExtern,
                                        Form => "WCEM=b");
            
         when SystemDatentypen.Linux_Enum =>
            Ada.Streams.Stream_IO.Open (File => DateiartExtern,
                                        Mode => Ada.Streams.Stream_IO.In_File,
                                        Name => NameExtern,
                                        Form => "WCEM=8");
      end case;
      
   end ÖffnenStream;
   
   
   
   procedure ErstellenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is begin
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when SystemDatentypen.Windows_Enum =>
            Ada.Wide_Wide_Text_IO.Create (File => DateiartExtern,
                                          Mode => Ada.Wide_Wide_Text_IO.Out_File,
                                          Name => NameExtern,
                                          Form => "WCEM=b");
            
         when SystemDatentypen.Linux_Enum =>
            Ada.Wide_Wide_Text_IO.Create (File => DateiartExtern,
                                          Mode => Ada.Wide_Wide_Text_IO.Out_File,
                                          Name => NameExtern,
                                          Form => "WCEM=8");
      end case;
      
   end ErstellenText;
   
   

   procedure ÖffnenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is begin
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when SystemDatentypen.Windows_Enum =>
            Ada.Wide_Wide_Text_IO.Open (File => DateiartExtern,
                                        Mode => Ada.Wide_Wide_Text_IO.In_File,
                                        Name => NameExtern,
                                        Form => "WCEM=b");
            
         when SystemDatentypen.Linux_Enum =>
            Ada.Wide_Wide_Text_IO.Open (File => DateiartExtern,
                                        Mode => Ada.Wide_Wide_Text_IO.In_File,
                                        Name => NameExtern,
                                        Form => "WCEM=8");
      end case;
      
   end ÖffnenText;
   
   
   
   procedure ErweiternText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is begin
      
      case
        Projekteinstellungen.Einstellungen.Betriebssystem
      is
         when SystemDatentypen.Windows_Enum =>
            Ada.Wide_Wide_Text_IO.Open (File => DateiartExtern,
                                        Mode => Ada.Wide_Wide_Text_IO.Append_File,
                                        Name => NameExtern,
                                        Form => "WCEM=b");
            
         when SystemDatentypen.Linux_Enum =>
            Ada.Wide_Wide_Text_IO.Open (File => DateiartExtern,
                                        Mode => Ada.Wide_Wide_Text_IO.Append_File,
                                        Name => NameExtern,
                                        Form => "WCEM=8");
      end case;
      
   end ErweiternText;
   
end DateiLogik;
