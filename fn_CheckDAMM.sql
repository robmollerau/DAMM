USE <database>
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* Use create instead of alter for first time */
create function [dbo].[fn_CheckDAMM]
(
	@vchr_value varchar( 100 )	    
)
returns bit
as
begin

	declare @bit_valid_code  bit
	declare @bit_valid_damm  bit

	declare @int_ctr         int
	declare @int_pos         int
	declare @int_interim     int
	declare @int_digit       int
	declare @int_checksum    int
	declare @int_len_value   int

	declare @chr_value       char( 1 )

	declare @chr_damm_0      char( 10 )
	declare @chr_damm_1      char( 10 )
	declare @chr_damm_2      char( 10 )
	declare @chr_damm_3      char( 10 )
	declare @chr_damm_4      char( 10 )
	declare @chr_damm_5      char( 10 )
	declare @chr_damm_6      char( 10 )
	declare @chr_damm_7      char( 10 )
	declare @chr_damm_8      char( 10 )
	declare @chr_damm_9      char( 10 )

	set @chr_damm_0 = '0317598642'
	set @chr_damm_1 = '7092154863'
	set @chr_damm_2 = '4206871359'
	set @chr_damm_3 = '1750983426'
	set @chr_damm_4 = '6123045978'
	set @chr_damm_5 = '3674209581'
	set @chr_damm_6 = '5869720134'
	set @chr_damm_7 = '8945362017'
	set @chr_damm_8 = '9438617205'
	set @chr_damm_9 = '2581436790'

	set @bit_valid_damm = 0

	set @int_len_value = len( @vchr_value )

	/* Only process if all digits valid */
	set @int_ctr = 1
	set @bit_valid_code = 1
	while @int_ctr <= @int_len_value begin
    
		set @int_pos = charindex( substring( @vchr_value, @int_ctr, 1 ), '0123456789' )
    
		/* Set flag if there is invalid character */
		if ( @int_pos = 0 ) begin
			set @bit_valid_code = 0
			break
		end
      
		set @int_ctr = @int_ctr + 1
      
	end 
    
	/* If code valid continue processing */
	if ( @bit_valid_code = 1 ) begin
    
		set @int_ctr = 1
      
		set @int_interim = 0
      
		/* Extract last digit of code for comparison */
		set @int_checksum = cast( right( @vchr_value, 1 ) as int )
      
		/* First 8 digits are damm encoded and compared to last checksum digit */
		while @int_ctr < ( @int_len_value - 1 ) begin
        
			/* Store code offset for processing */
			set @chr_value = substring( @vchr_value, @int_ctr, 1 )        
        
			/* Convert hex values to integer equivalent */
			/* set @int_digit = cast( convert( varbinary, '0' + @chr_value, 2 ) as int ) */
			set @int_digit = cast( @chr_value as int )
        
			/* Retrieve next interim based on last interim and current digit */
			set @int_interim = 
				case @int_interim
					when 0 then cast( substring( @chr_damm_0, @int_digit + 1, 1 ) as int )
					when 1 then cast( substring( @chr_damm_1, @int_digit + 1, 1 ) as int )
					when 2 then cast( substring( @chr_damm_2, @int_digit + 1, 1 ) as int )
					when 3 then cast( substring( @chr_damm_3, @int_digit + 1, 1 ) as int )
					when 4 then cast( substring( @chr_damm_4, @int_digit + 1, 1 ) as int )
					when 5 then cast( substring( @chr_damm_5, @int_digit + 1, 1 ) as int )
					when 6 then cast( substring( @chr_damm_6, @int_digit + 1, 1 ) as int )
					when 7 then cast( substring( @chr_damm_7, @int_digit + 1, 1 ) as int )
					when 8 then cast( substring( @chr_damm_8, @int_digit + 1, 1 ) as int )
					when 9 then cast( substring( @chr_damm_9, @int_digit + 1, 1 ) as int )
				end  
          
			set @int_ctr = @int_ctr + 1
      
		end
      
		/* Compare passed and calculated checksums - if different overwrite column */
		if ( @int_checksum = @int_interim ) begin
			set @bit_valid_damm = 1
		end
		else begin
			set @bit_valid_damm = 0
		end
      
	end  

	return @bit_valid_damm
     
end



GO

